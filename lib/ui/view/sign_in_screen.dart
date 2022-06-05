import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:we_eat/asset/data/service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController id = TextEditingController();

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
                controller: id,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: '비밀번호 입력',
                  hintText: '',
                ),
              ),
              Spacer(flex: 3),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () => Get.offAllNamed(Service.MAIN_ROUTE),
                  child: Text('로그인'),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: OutlinedButton(
                  onPressed: () => Get.toNamed(Service.SIGN_UP_ROUTE),
                  child: Text('회원가입'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
