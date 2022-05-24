import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:we_eat/asset/data/schinfo.dart';
import 'package:we_eat/ui/component/board_component.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController id = TextEditingController();
  String defaultMajor = SchInfo.major[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.close),
            color: Colors.black,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            SizedBox(height: 15),
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
            SizedBox(height: 40),
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
                    controller: id,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: '이름 입력',
                      hintText: '김철수',
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '학번',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  TextFormField(
                    controller: id,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: '학번 입력',
                      hintText: '',
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '전공',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFDFD),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border: Border.all(
                        color: Color.fromARGB(255, 198, 198, 198),
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
                        onChanged: (String? newValue) {},
                        items: SchInfo.major
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () => null,
                child: Text('회원가입'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
