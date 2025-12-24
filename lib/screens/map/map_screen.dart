import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:euro/constants/constants.dart';
import 'package:euro/generated/l10n.dart';
import 'package:euro/screens/map/cubit/map_cubit.dart';
import 'package:euro/screens/widgets/online_builder.dart';
import 'package:euro/utils/paths/image_path.dart';
import 'package:euro/utils/whatsapp_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/app_colors.dart';
import '../services/widgets/language_dialog.dart';

class MapScreen extends StatefulWidget {
  final LatLng location;

  const MapScreen({
    super.key,
    required this.location,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  int _markerIdCounter = 0;
  final Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController? _controller;
  bool _isDisposed = false;
  LatLng? _selectedLocation;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    if (_isDisposed) return;
    
    _mapController.complete(controller);
    _controller = controller;
    
    try {
      MarkerId markerId = MarkerId(_markerIdVal());
      LatLng position = widget.location;
      final Uint8List? markerIcon = await _loadMarkerIcon();
      
      if (_isDisposed) return;
      
      Marker marker = Marker(
        icon: markerIcon != null 
            ? BitmapDescriptor.bytes(markerIcon)
            : BitmapDescriptor.defaultMarker,
        markerId: markerId,
        position: position,
        draggable: false,
      );
      
      if (mounted) {
        setState(() {
          _markers[markerId] = marker;
        });
      }

      Future.delayed(const Duration(seconds: 1), () async {
        if (_isDisposed || !mounted) return;
        try {
          final mapController = await _mapController.future;
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: position,
                zoom: 16.0,
              ),
            ),
          );
        } catch (e) {
          debugPrint('Error animating camera: $e');
        }
      });
    } catch (e) {
      debugPrint('Error in _onMapCreated: $e');
    }
  }
  
  Future<Uint8List?> _loadMarkerIcon() async {
    try {
      return await getBytesFromAsset('assets/images/png/ic_marker.png', 65);
    } catch (e) {
      debugPrint('Error loading marker icon: $e');
      return null;
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  String _markerIdVal({bool increment = false}) {
    String val = 'marker_id_$_markerIdCounter';
    if (increment) _markerIdCounter++;
    return val;
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  final List<File> _images = [];

  // Method to show dialog and pick image
  Future<void> _showPickerDialog() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(S.current.gallery),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(S.current.camera),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Method to pick image from the selected source
  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
          source: source,
          imageQuality: 40,
          requestFullMetadata: false,
          maxHeight: 800,
          maxWidth: 480);

      if (pickedFile != null && mounted) {
        setState(() {
          _images.add(File(pickedFile.path));
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: $e')),
        );
      }
    }
  }

  // Method to delete an image from the list
  void _deleteImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return OnlineBuilder(
      onlineWidget: SafeArea(
        child: BlocProvider(
          create: (context) => MapCubit(),
          child: Builder(builder: (context) {
            final MapCubit mapCubit = BlocProvider.of<MapCubit>(context);
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      WhatsAppMessage.whatsappMessage(roadsideWhatsApp, '');
                    },
                    icon: const Icon(Icons.call),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const LanguageDialog();
                          });
                      setState(() {});
                    },
                    icon: const Icon(Icons.language),
                  ),
                ],
                title: Image.asset(
                  ImagePath.getPng(imageName: "logo"),
                  height: 45,
                ),
                backgroundColor: AppColors.grey,
              ),
              body: BlocListener<MapCubit, MapState>(
                listener: (context, state) {
                  if (state is MapError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                child: Stack(
                  children: [
                    GoogleMap(
                      markers: Set<Marker>.of(_markers.values),
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: widget.location,
                        zoom: 12.0,
                      ),
                      myLocationEnabled: true,
                      onCameraMove: (CameraPosition position) {
                        if (_markers.isNotEmpty) {
                          MarkerId markerId = MarkerId(_markerIdVal());
                          Marker marker = _markers[markerId]!;
                          Marker updatedMarker = marker.copyWith(
                            positionParam: position.target,
                          );

                          setState(() {
                            _markers[markerId] = updatedMarker;
                            _selectedLocation = position.target;
                          });
                        }
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: (MediaQuery.of(context).size.height * 0.42).h,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18),
                            ),
                            color: Colors.white.withOpacity(0.7)),
                        child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: BlocBuilder<MapCubit, MapState>(
                              builder: (context, state) {
                                if (state is MapLoaded) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(S.of(context).succeeded),
                                      const SizedBox(
                                        height: 100,
                                      ),
                                      Container(
                                        color: AppColors.grey,
                                        child: Center(
                                          child: InkWell(
                                            onTap: () async {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          200),
                                                  color: AppColors.red),
                                              child: Center(
                                                child: Text(
                                                  S.of(context).ok,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                } else {
                                  return Form(
                                    key: formKey,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextFormField(
                                            keyboardType: TextInputType.phone,
                                            validator: (value) {
                                              return mapCubit.validateMoblie(
                                                  mobile: value ?? "");
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  S.of(context).mobileNumber,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          TextFormField(
                                            validator: (value) {
                                              return mapCubit.validateNote(
                                                  note: value ?? "");
                                            },
                                            maxLines: 2,
                                            decoration: InputDecoration(
                                              hintText:
                                                  S.of(context).typeMessage,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                    Icons.add_a_photo),
                                                onPressed: _showPickerDialog,
                                              ),
                                              Expanded(
                                                child: _images.isEmpty
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                        child: InkWell(
                                                          onTap:
                                                              _showPickerDialog,
                                                          child: Text(S.current
                                                              .addImages),
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        height: 80,
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          shrinkWrap: true,
                                                          itemCount:
                                                              _images.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Stack(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    child: Image
                                                                        .file(
                                                                      _images[
                                                                          index],
                                                                      width:
                                                                          100,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  right: 0,
                                                                  top: 0,
                                                                  child:
                                                                      IconButton(
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .cancel,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                    onPressed: () =>
                                                                        _deleteImage(
                                                                            index),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ),
                                              ),
                                            ],
                                          ),
                                          BlocBuilder<MapCubit, MapState>(
                                            builder: (context, state) {
                                              if (state is MapLoading) {
                                                return Container(
                                                  color: AppColors.grey,
                                                  child: Center(
                                                    child: Container(
                                                      width: double.infinity,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 16,
                                                          vertical: 8),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      200),
                                                          color: AppColors.red),
                                                      child: const Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else if (state is MapLoaded) {
                                                return Container(
                                                  color: AppColors.grey,
                                                  child: Center(
                                                    child: InkWell(
                                                      onTap: () async {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        width: double.infinity,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 16,
                                                                vertical: 8),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        200),
                                                            color:
                                                                AppColors.red),
                                                        child: Center(
                                                          child: Text(
                                                            S.of(context).ok,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Container(
                                                  color: AppColors.grey,
                                                  child: Center(
                                                    child: InkWell(
                                                      onTap: () async {
                                                        if (formKey
                                                            .currentState!
                                                            .validate()) {
                                                          await mapCubit.sendHelp(
                                                              latLng: _selectedLocation ??
                                                                  widget
                                                                      .location,
                                                              files: _images);
                                                        }
                                                      },
                                                      child: Container(
                                                        width: double.infinity,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 16,
                                                                vertical: 8),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        200),
                                                            color:
                                                                AppColors.red),
                                                        child: Center(
                                                          child: Text(
                                                            S
                                                                .of(context)
                                                                .requestAssistance,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              },
                            )),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller?.dispose();
    super.dispose();
  }
}
