import 'dart:convert';

import 'package:bcrypt/bcrypt.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sfiasset/components/custom_surfix_icon.dart';
import 'package:sfiasset/components/default_buttom.dart';
import 'package:sfiasset/components/normal_dialog.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/screens/home/publicize_screen/publicize_screen.dart';
import 'package:sfiasset/screens/jobEntry/job_registor/job_registor.dart';
import 'package:sfiasset/screens/jobEntry/job_reset_password/job_reset_password.dart';
import 'package:sfiasset/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app_localizations.dart';

class JobSignFrom extends StatefulWidget {
  const JobSignFrom({super.key});

  @override
  State<JobSignFrom> createState() => _JobSignFromState();
}

class _JobSignFromState extends State<JobSignFrom> {
  final _formKey = GlobalKey<FormState>();
  String? email, password, empCode;
  bool passwordVisable = true;

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildEmailFormField(),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                buildPassFormField(),
                SizedBox(
                  height: getProportionateScreenHeight(30.0),
                ),
                DefaultButton(
                    text: AppLocalizations.of(context).translate('continue'),
                    press: () {
                      bool pass = _formKey.currentState!.validate();
                      if (pass) {
                        if (isChecked) {
                          print('email = $email, password = $password');
                          checkLogin();

                          // if(BCrypt.checkpw(password!, _passWord)){
                          //
                          // }
                         // checkAuthen();
                        } else {
                          normalDialog(
                              context,
                              AppLocalizations.of(context)
                                  .translate('acceptPolicy'),Icons.local_police,Colors.green);
                        }
                        // checkAuthens();
                      }
                    }),
                SizedBox(
                  height: getProportionateScreenHeight(5.0),
                ),
                TextButton(
                    onPressed: (){
                      print('สมัครสมาชิก');
                      Navigator.pushNamed(context, JobRegistor.routName);
                    },
                    child: Text('สมัครสมาชิก',style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: getProportionateScreenHeight(18)))),
                TextButton(
                    onPressed: (){
                      print('ลืมรหัสผ่าน');
                      // showDialog(context: context, builder: (context) => AlertDialog(
                      //   title: Text('ลืมรหัสผ่าน'),
                      //   content: const Text('กรุณาติดต่อเจ้าหน้าที่ โทร 077-521-321 ต่อ 222'),
                      //   actions: [
                      //     TextButton(onPressed: (){
                      //       Navigator.pop(context);
                      //     }, child: Text('ตกลง'))
                      //   ],
                      // ));
                      Navigator.pop(context);
                      Navigator.pushNamed(context, JobResetPassword.routName);
                    },
                    child: Text('ลืมรหัสผ่าน',style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: getProportionateScreenHeight(18)))),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, PublicezeScreen.routName,
                          arguments: {
                            'id': '30',
                            'webViewType': 'webview',
                            'publicizeDetail': ''
                          });
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('privatePolicy'),//นโยบายความเป็นส่วนตัว
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: getProportionateScreenHeight(18)),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        }),
                    Text(
                      AppLocalizations.of(context).translate('acceptPolicy'),
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: getProportionateScreenHeight(18),
                      ),
                    )
                  ],
                ),

              ],
            )),

      ],
    );
  }
  TextFormField buildEmailFormField() {
    return TextFormField(
      onChanged: (value) => {email = value.trim()},
      validator: (value) {
        if (value.toString().isEmpty) {
          return AppLocalizations.of(context).translate('typeEmail');
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).translate('email'),
        hintText: AppLocalizations.of(context).translate('typeEmail'),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurfixIcon(
          press: () {},
          svgIcon: "assets/icons/User Icon.svg",
        ),
      ),
    );
  }

  TextFormField buildPassFormField() {
    return TextFormField(

      onChanged: (value) => {password = value.trim()},
      validator: (value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context).translate('typePassword');
        }
        return null;
      },
      obscureText: passwordVisable,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).translate('typePassword'),
        hintText: AppLocalizations.of(context).translate('typePassword'),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: PasswordVisableButton(),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding PasswordVisableButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenHeight(6),
        getProportionateScreenHeight(6),
        getProportionateScreenHeight(6),
      ),
      child: IconButton(
        onPressed: () {
          setState(() {
            passwordVisable = !passwordVisable;
          });
        },
        icon: Icon(
          passwordVisable ? Icons.visibility_off : Icons.visibility,
          size: getProportionateScreenHeight(16.0),
          color: kTextColor,
        ),
      ),
    );
  }
  Future<void> checkLogin() async {
   String url = "http://61.7.142.47:8086/sfi-hr/select_user_job.php?email=$email";
   await Dio().get(url).then((value)  {
     print('value = $value');
     if(value.toString() == 'null') {
       normalDialogLoginJob(context, 'ไม่มี $email ในระบบ กรุณาสมัครสมาชิกเพื่อใช้งาน', Icons.error, Colors.red, 'error');
     }else{
       var data = jsonDecode(value.data);
       print('data = $data');
       var _passWord = data[0]['PASSWORD'];
       var _email = data[0]['EMAIL'];
       var _userID = data[0]['ID'];
       print('_passWord = $_passWord');
       if(BCrypt.checkpw(password!, _passWord)){
          normalDialogLoginJob(context, 'ล๊อกอินสำเร็จ', Icons.check_circle, Colors.green,'success');
          setPerferance('email', _email);
          setPerferance('userID', _userID);
          setPerferance('password', _passWord);
       }else{
         normalDialogLoginJob(context, 'รหัสผ่านไม่ถูกต้อง', Icons.error, Colors.red, 'correct');
       }
     }
     //   var data = jsonDecode(value.data);
     // print('data = $data');
     // var _passWord = data[0]['PASSWORD'];
     //  print('_passWord = $_passWord');
      // if(value.toString() == 'null'){
      //   normalDialog(context, 'ไม่มี $email ในระบบ', Icons.error, Colors.red),
      // }else{

      //  // Navigator.pushNamed(context, JobRegistor.routName,arguments: {'email':email,'password':password}),

   });
  }

  Future<void> setPerferance(String key, String valude) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, valude);
  }
}
