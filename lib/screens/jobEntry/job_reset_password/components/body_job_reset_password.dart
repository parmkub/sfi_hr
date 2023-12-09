// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/components/custom_surfix_icon.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/size_config.dart';
class BodyJobResetPassword extends StatefulWidget {
  const BodyJobResetPassword({super.key});

  @override
  State<BodyJobResetPassword> createState() => _BodyJobResetPasswordState();
}

class _BodyJobResetPasswordState extends State<BodyJobResetPassword> {
  final _formKey = GlobalKey<FormState>();
  String? email;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: const BoxDecoration(
          gradient: kBackgroundColor,
          ),
          width: double.infinity,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Text("รีเซ็ตรหัสผ่าน",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height: 50,),
          Form(
            key: _formKey,
            child: Column(
              children: [
                buildEmailFormField(),
                SizedBox(height: 20,),
                ElevatedButton(
                  child: Text("รีเซตรหัสผ่าน",style: TextStyle(fontSize: 20),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      resertPassword();
                      // Do something like updating SharedPreferences or User Settings etc.
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('Processing Data')),
                      // );
                    }
                  },
                  ),
              ],
            ),
          )
        ],
      ),
    ));
  }
  Future<void> resertPassword() async {
    String url = "http://61.7.142.47:3002/resetpassword?email=$email";

      Response response = await Dio().get(url);
      var result = jsonDecode(response.toString());
      print(result);
      if(result['RespMassage'] == 'good'){
        showDialog(context: context, builder: (
            BuildContext context) {
          return AlertDialog(
            title: const Text("สำเร็จ"),
            content: Container(
              height: getProportionateScreenHeight(300),
              child: Column(
                children: [
                  Icon(Icons.check_circle_outline,color: Colors.green,size: 100,),
                  SizedBox(
                    height: 10,
                  ),
                  Text("กรุณาตรวจสอบอีเมล์",style: TextStyle(fontSize: 20),),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              }, child: const Text("ตกลง"))
            ],
          );
        });
      }


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
}
