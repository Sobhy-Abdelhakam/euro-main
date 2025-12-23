import 'package:euro/constants/constants.dart';
import 'package:euro/generated/l10n.dart';
import 'package:euro/screens/profile/cubit/profile_cubit.dart';
import 'package:euro/utils/app_colors.dart';
import 'package:euro/utils/paths/image_path.dart';
import 'package:euro/utils/whatsapp_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/widgets/language_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                WhatsAppMessage.whatsappMessage(roadsideWhatsApp, '');
              },
              icon: const Icon(Icons.call),
            ),
            IconButton(onPressed: (){
              
              showDialog(
                  context: context,
                  builder: (context) {
                    return const LanguageDialog();
                  });setState((){});
            }, icon: const Icon(Icons.language),),
            
          ],
        title: Image.asset(
          ImagePath.getPng(imageName: "logo"),
          height: 45,
        ),
        backgroundColor: AppColors.grey,
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 40),
          child: Container(
              height: 40,
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: Text(
                  S.of(context).profile,
                  style: const TextStyle(
                    color: Color(0xffe01e26),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context) => ProfileCubit(),
          child: Builder(builder: (context) {
            final ProfileCubit profileCubit =
                BlocProvider.of<ProfileCubit>(context);
            return Form(
              key: profileCubit.formKey,
              child: BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is ProfileMessage) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Column(
                        children: [
                          TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: profileCubit.nameController,
                              // validator: (value) {
                              //   return profileCubit.validate(
                              //       text: value ?? "",
                              //       feildName: S.of(context).user_name);
                              // },
                              decoration: InputDecoration(
                                  label: Text(S.of(context).user_name))),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                              keyboardType: TextInputType.number,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: profileCubit.phoneController,
                              validator: (value) {
                                return profileCubit.validate(
                                    text: value ?? "",
                                    feildName: S.of(context).phone_number);
                              },
                              decoration: InputDecoration(
                                  label: Text(S.of(context).phone_number))),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: profileCubit.addressController,
                              // validator: (value) {
                              //   return profileCubit.validate(
                              //       text: value ?? "",
                              //       feildName: S.of(context).address);
                              // },
                              decoration: InputDecoration(
                                  label: Text(S.of(context).address))),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: profileCubit.documentIdController,
                              // validator: (value) {
                              //   return profileCubit.validate(
                              //       text: value ?? "",
                              //       feildName: S.of(context).document_id);
                              // },
                              decoration: InputDecoration(
                                  label: Text(S.of(context).document_id))),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: profileCubit.documentSourceController,
                              // validator: (value) {
                              //   return profileCubit.validate(
                              //       text: value ?? "",
                              //       feildName: S.of(context).document_source);
                              // },
                              decoration: InputDecoration(
                                  label: Text(S.of(context).document_source))),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: profileCubit.carTypeController,
                              // validator: (value) {
                              //   return profileCubit.validate(
                              //       text: value ?? "",
                              //       feildName: S.of(context).car_type);
                              // },
                              decoration: InputDecoration(
                                  label: Text(S.of(context).car_type))),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: profileCubit.carModelController,
                              // validator: (value) {
                              //   return profileCubit.validate(
                              //       text: value ?? "",
                              //       feildName: S.of(context).car_model);
                              // },
                              decoration: InputDecoration(
                                  label: Text(S.of(context).car_model))),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller:
                                        profileCubit.carNumbersController,
                                    // validator: (value) {
                                    //   return profileCubit.validate(
                                    //       text: value ?? "",
                                    //       feildName: S.of(context).car_numbers);
                                    // },
                                    decoration: InputDecoration(
                                        label:
                                            Text(S.of(context).car_numbers))),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller:
                                        profileCubit.carLettersController,
                                    // validator: (value) {
                                    //   return profileCubit.validate(
                                    //       text: value ?? "",
                                    //       feildName: S.of(context).car_letters);
                                    // },
                                    decoration: InputDecoration(
                                        label:
                                            Text(S.of(context).car_letters))),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                              keyboardType: TextInputType.number,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: profileCubit.chassisNumbersController,
                              // validator: (value) {
                              //   return profileCubit.validate(
                              //       text: value ?? "",
                              //       feildName: S.of(context).chassis_Number);
                              // },
                              decoration: InputDecoration(
                                  label: Text(S.of(context).chassis_Number))),
                          const SizedBox(
                            height: 32,
                          ),
                          Container(
                            color: AppColors.grey,
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  profileCubit.save();
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200),
                                      color: AppColors.red),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.save,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        S.of(context).save,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
