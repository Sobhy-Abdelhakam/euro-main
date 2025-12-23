import 'package:euro/generated/l10n.dart';
import 'package:euro/models/user_model.dart';
import 'package:euro/utils/hive/hive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()) {
    _getCurrentUser();
  }

  late UserModel _currentUser;
  UserModel? _savedUser;

  void _getCurrentUser() {
    _savedUser = HiveUtils.getUser;
    if (_savedUser != null) {
      nameController.text = _savedUser!.name ?? "";
      phoneController.text = _savedUser!.phoneNumber.toString();
      addressController.text = _savedUser!.address ?? "";
      documentIdController.text = _savedUser!.membershipId?.toString() ?? "";
      documentSourceController.text = _savedUser!.membershipSource ?? "";
      carTypeController.text = _savedUser!.carType ?? "";
      carModelController.text = _savedUser!.carModel ?? "";
      carNumbersController.text = _savedUser!.carNumbers?.toString() ?? "";
      carLettersController.text = _savedUser!.carChars ?? "";
      chassisNumbersController.text = _savedUser!.sashaNumber?.toString() ?? "";
    }
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController documentIdController = TextEditingController();
  TextEditingController documentSourceController = TextEditingController();
  TextEditingController carTypeController = TextEditingController();
  TextEditingController carModelController = TextEditingController();
  TextEditingController carNumbersController = TextEditingController();
  TextEditingController carLettersController = TextEditingController();
  TextEditingController chassisNumbersController = TextEditingController();

  String? validate({required String text, required String feildName}) {
    if (text.isEmpty) {
      return S.current.emptyField(feildName);
    } else {
      return null;
    }
  }

  void save() {
    if (formKey.currentState!.validate()) {
      _currentUser = UserModel(
          name: nameController.text,
          address: addressController.text,
          carChars: carLettersController.text,
          carModel: carModelController.text,
          carNumbers: carNumbersController.text.isNotEmpty
              ? int.parse(carNumbersController.text)
              : null,
          carType: carTypeController.text,
          membershipId: documentIdController.text,
          membershipSource: documentSourceController.text,
          phoneNumber: int.parse(phoneController.text),
          sashaNumber: chassisNumbersController.text.isNotEmpty
              ? int.parse(chassisNumbersController.text)
              : null);
      if (_savedUser == null) {
        HiveUtils.saveUser(_currentUser);
        emit(ProfileMessage(message: S.current.saved_successfully));
      } else {
        if (_savedUser == _currentUser) {
          emit(ProfileMessage(message: S.current.no_changes));
        } else {
          HiveUtils.saveUser(_currentUser);
          emit(ProfileMessage(message: S.current.saved_successfully));
        }
      }
    }
  }
}
