// ignore_for_file: non_constant_identifier_names

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:we_eat/asset/data/schinfo.dart';
import 'package:we_eat/asset/status/validate.dart';

class ValidateController extends GetxController {
  // sign up
  String? inputID;
  String? inputPW;
  String? inputName;
  String? inputSID;
  String inputDept = SchInfo.major[0];

  // sign in
  String? id;
  String? pw;

  // Indicator Check
  bool isIDValidated = false;
  bool isPWValidated = false;
  bool isNameValidated = false;
  bool isSIDValidated = false;

  bool isSignInIDValidated = false;
  bool isSignInPWValidated = false;

  Validate validateChat(String message) {
    if (message.isEmpty) {
      return Validate.minLength;
    }
    if (message.length > 255) {
      return Validate.maxLength;
    }
    return Validate.pass;
  }

  Validate validatePW(String pw) {
    if (pw.contains(RegExp(r'[\s]'))) {
      return Validate.containSpace;
    }
    if (!pw.contains(RegExp(r'^[a-zA-Z0-9]+$'))) {
      return Validate.containSpecialChar;
    }
    if (pw.length < 6) {
      return Validate.minLength;
    }
    if (pw.length > 15) {
      return Validate.maxLength;
    }
    return Validate.pass;
  }

  Validate validateID(String id) {
    if (id.length < 8) {
      return Validate.minLength;
    }
    if (id.contains(RegExp(r'[\s]'))) {
      return Validate.containSpace;
    }
    if (!id.contains(RegExp(r'^[a-zA-Z0-9]+$'))) {
      return Validate.containSpecialChar;
    }
    if (id.length > 15) {
      return Validate.maxLength;
    }
    return Validate.pass;
  }

  Validate validateName(String name) {
    if (name.contains(RegExp(r'[\s]'))) {
      return Validate.containSpace;
    }

    if (RegExp(r'[\uac00-\ud7af]', unicode: true).allMatches(name).length !=
            name.length &&
        !name.contains(RegExp(r'^[a-zA-Z0-9가-힣]+$'))) {
      return Validate.uncompliteWord;
    }
    if (name == 'admin' || name == 'root' || name == '관리자' || name == '운영자') {
      return Validate.error;
    }
    if (name.length < 2) {
      return Validate.minLength;
    }
    if (name.length > 6) {
      return Validate.maxLength;
    }

    return Validate.pass;
  }

  Validate validateSID(String SID) {
    if (SID.contains(RegExp(r'[\s]'))) {
      return Validate.containSpace;
    }
    if (!SID.contains(RegExp(r'^[0-9]+$'))) {
      return Validate.containSpecialChar;
    }
    if (SID.length != 9) {
      return Validate.minLength;
    }
    return Validate.pass;
  }

  Validate comparePW(String rePw) {
    if (validatePW(rePw) == Validate.pass) {
      if (inputPW != rePw) {
        return Validate.notMatchPW;
      }
      return Validate.pass;
    }
    return Validate.error;
  }

  bool checkSignUpValidated() =>
      isIDValidated && isPWValidated && isNameValidated && isSIDValidated;

  bool checkSignInValidated() => isSignInIDValidated && isSignInPWValidated;
}
