// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:we_eat/asset/data/schinfo.dart';
import 'package:we_eat/asset/status/validate.dart';
import 'package:we_eat/ui/component/board_component.dart';
import 'package:we_eat/view_model/controller/auth_controller.dart';
import 'package:we_eat/view_model/controller/sign_controller.dart';
import 'package:we_eat/view_model/controller/validate_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignController _signController = Get.put(SignController());
  final ValidateController _validateController = Get.put(ValidateController());

  TextEditingController id = TextEditingController();
  TextEditingController pw = TextEditingController();
  TextEditingController r_pw = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController s_id = TextEditingController();

  String defaultMajor = SchInfo.major[0];

  bool _isPwVisible = true;
  bool _isRePwVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close),
            color: Colors.black,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '아이디 입력',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            TextFormField(
              controller: id,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: '아이디 입력',
                hintText: '',
              ),
              validator: (val) {
                _validateController.isIDValidated = false;
                if (val == null || val.isEmpty || val != id.text) {
                  return '아이디를 입력하세요.';
                } else {
                  switch (_validateController.validateID(val)) {
                    case Validate.pass:
                      _validateController.inputID = id.text;
                      _validateController.isIDValidated = true;
                      return null;
                    case Validate.minLength:
                      return 'ID는 8글자 이상이여야 합니다.';
                    case Validate.containSpace:
                      return '띄어쓰기는 할 수 없어요.';
                    case Validate.containSpecialChar:
                      return 'ID는 영어(대소문자), 숫자만 허용합니다.';
                    case Validate.maxLength:
                      return 'ID는 15글자 이하여야 합니다.';
                    default:
                      return '잘못된 입력입니다.';
                  }
                }
              },
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '비밀번호 입력',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            TextFormField(
              controller: pw,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: '비밀번호 입력',
                hintText: '',
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPwVisible = !_isPwVisible;
                    });
                  },
                  child: Icon(
                    _isPwVisible ? Icons.visibility : Icons.visibility_off,
                    color: const Color.fromARGB(255, 175, 175, 175),
                  ),
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: _isPwVisible,
              validator: (val) {
                _validateController.inputPW = '';
                if (val == null || val.isEmpty) {
                  return '비밀번호를 입력하세요.';
                } else {
                  switch (_validateController.validatePW(val)) {
                    case Validate.containSpace:
                      return '띄어쓰기는 포함할 수 없습니다.';
                    case Validate.minLength:
                      return '6자리 이상이여야 합니다.';
                    case Validate.maxLength:
                      return '15자리 이하이여야 합니다.';
                    case Validate.notContainNumber:
                      return '숫자를 포함해야 합니다.';
                    case Validate.containSpecialChar:
                      return '특수문자는 포함할 수 없습니다.';
                    case Validate.pass:
                      _validateController.inputPW = val;
                      return null;
                    default:
                      return '알 수 없는 에러, 관리자에게 문의하세요.';
                  }
                }
              },
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '비밀번호 재입력',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            TextFormField(
              controller: r_pw,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: '비밀번호 입력',
                hintText: '',
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isRePwVisible = !_isRePwVisible;
                    });
                  },
                  child: Icon(
                    _isRePwVisible ? Icons.visibility : Icons.visibility_off,
                    color: const Color.fromARGB(255, 175, 175, 175),
                  ),
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: _isRePwVisible,
              validator: (val) {
                _validateController.isPWValidated = false;
                if (val == null || val.isEmpty) {
                  return '비밀번호를 입력하세요.';
                } else {
                  switch (_validateController.comparePW(val)) {
                    case Validate.notMatchPW:
                      return '비밀번호가 일치하지 않습니다.';
                    case Validate.pass:
                      _validateController.isPWValidated = true;
                      return null;
                    case Validate.error:
                    default:
                      return '비밀번호를 정확히 입력해주세요.';
                  }
                }
              },
            ),
            const SizedBox(height: 40),
            BoardComponent(
              title: '인적사항 입력',
              paddingR: 0.0,
              paddingL: 0.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '이름',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  TextFormField(
                    controller: name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: '이름 입력',
                      hintText: '김철수',
                    ),
                    validator: (val) {
                      _validateController.inputName = '';
                      _validateController.isNameValidated = false;
                      if (val == null || val.isEmpty) {
                        return '닉네임을 입력하세요.';
                      } else {
                        switch (_validateController.validateName(val)) {
                          case Validate.containSpace:
                            return '띄어쓰기는 포함할 수 없습니다.';
                          case Validate.minLength:
                            return '2글자 이상이여야 합니다.';
                          case Validate.maxLength:
                            return '6글자 이하이여야 합니다.';
                          case Validate.uncompliteWord:
                            return '형식에 맞지 않는 이름입니다.';
                          case Validate.pass:
                            _validateController.inputName = val;
                            _validateController.isNameValidated = true;
                            return null;
                          default:
                            return '알 수 없는 에러, 관리자에게 문의하세요.';
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '학번',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  TextFormField(
                    controller: s_id,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '학번 입력',
                      hintText: '',
                    ),
                    validator: (val) {
                      _validateController.inputSID = '';
                      _validateController.isSIDValidated = false;
                      if (val == null || val.isEmpty) {
                        return '학번을 입력하세요.';
                      } else {
                        switch (_validateController.validateSID(val)) {
                          case Validate.containSpace:
                            return '띄어쓰기는 포함할 수 없습니다.';
                          case Validate.containSpecialChar:
                            return '오직 숫자만 입력가능합니다.';
                          case Validate.minLength:
                            return '학번은 9자리이여야 합니다.';
                          case Validate.pass:
                            _validateController.inputSID = val;
                            _validateController.isSIDValidated = true;
                            return null;
                          default:
                            return '알 수 없는 에러, 관리자에게 문의하세요.';
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '전공',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFDFD),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border: Border.all(
                        color: const Color.fromARGB(255, 198, 198, 198),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: DropdownButton<String>(
                        value: defaultMajor,
                        icon: const Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                        elevation: 16,
                        style: Theme.of(context).textTheme.headline5,
                        underline: Container(),
                        items: SchInfo.major
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          _validateController.inputDept = newValue!;
                          setState(() {
                            defaultMajor = newValue.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                child: const Text('회원가입'),
                onPressed: () async {
                  if (_validateController.checkSignUpValidated()) {
                    await _signController.signUp({
                      'user_id': _validateController.inputID,
                      'user_pw': _validateController.inputPW,
                      'user_name': _validateController.inputName,
                      'user_sid': _validateController.inputSID,
                      'user_dept': _validateController.inputDept,
                    });
                  } else {
                    if (!_validateController.isIDValidated) {
                      Get.snackbar('회원가입 실패', '아이디를 입력해주세요.');
                    } else if (!_validateController.isPWValidated) {
                      Get.snackbar('회원가입 실패', '비밀번호를 입력/재입력 해주세요.');
                    } else if (!_validateController.isNameValidated) {
                      Get.snackbar('회원가입 실패', '이름을 입력해주세요.');
                    } else if (!_validateController.isSIDValidated) {
                      Get.snackbar('회원가입 실패', '학번을 입력해주세요.');
                    } else {
                      Get.snackbar('회원가입 실패', '다시 시도해주세요.');
                    }
                  }

                  log(AuthController.to.user.toString());
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
