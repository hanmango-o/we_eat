import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:we_eat/asset/data/service.dart';
import 'package:we_eat/asset/status/validate.dart';
import 'package:we_eat/view_model/controller/sign_controller.dart';
import 'package:we_eat/view_model/controller/validate_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignController _signController = Get.put(SignController());
  final ValidateController _validateController = Get.put(ValidateController());

  TextEditingController id = TextEditingController();
  TextEditingController pw = TextEditingController();

  bool _isPwVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: SizedBox(
          height: 650.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'id',
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
                  _validateController.isSignInIDValidated = false;
                  if (val == null || val.isEmpty || val != id.text) {
                    return '아이디를 입력하세요.';
                  } else {
                    switch (_validateController.validateID(val)) {
                      case Validate.pass:
                        _validateController.id = id.text;
                        _validateController.isSignInIDValidated = true;
                        return null;
                      default:
                        return '';
                    }
                  }
                },
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'pw',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              TextFormField(
                controller: pw,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _isPwVisible,
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
                validator: (val) {
                  _validateController.pw = '';
                  _validateController.isSignInPWValidated = false;
                  if (val == null || val.isEmpty) {
                    return '비밀번호를 입력하세요.';
                  } else {
                    switch (_validateController.validatePW(val)) {
                      case Validate.pass:
                        _validateController.pw = val;
                        _validateController.isSignInPWValidated = true;
                        return null;
                      default:
                        return '';
                    }
                  }
                },
              ),
              Spacer(flex: 3),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  child: Text('로그인'),
                  onPressed: () async {
                    if (_validateController.checkSignInValidated()) {
                      await _signController.signIn({
                        'user_id': _validateController.id,
                        'user_pw': _validateController.pw,
                      });
                    } else {
                      Get.snackbar('잘못된 아이디/비밀번호 입력', '형식에 맞게 다시 입력해주세요.');
                    }
                  },
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: OutlinedButton(
                  child: Text('회원가입'),
                  onPressed: () => Get.toNamed(Service.SIGN_UP_ROUTE),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
