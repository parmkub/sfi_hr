// ignore_for_file: use_build_context_synchronously, avoid_print


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfiasset/components/custom_surfix_icon.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/model/job_user_profile_model.dart';
import 'package:sfiasset/providers/Job_user_profile_provider.dart';
import 'package:sfiasset/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constans.dart';


class BodyJobEditProfile extends StatefulWidget {
  const BodyJobEditProfile({super.key});

  @override
  State<BodyJobEditProfile> createState() => _BodyJobEditProfileState();
}

class _BodyJobEditProfileState extends State<BodyJobEditProfile> {
  final _formKey = GlobalKey<FormState>();

  String? email, firstName, lastName,phone,address;

  String? userID;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfile();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
              width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Card(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: kBackgroundColor,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Card(
                              color: kSecondaryColor,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                width: double.infinity,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "แก้ไขโปรไฟล์",
                                    style: TextStyle(
                                        fontSize: getProportionateScreenWidth(18),
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 40,),
                                    buildEmailFormField(),
                                    const SizedBox(height: 20,),
                                    buildFNameFormField(),
                                    const SizedBox(height: 20,),
                                    buildLNameFormField(),
                                    const SizedBox(height: 20,),
                                    buildPhoneFormField(),
                                    const SizedBox(height: 20,),
                                    buildAddressFormField(),
                                    const SizedBox(height: 40,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: kSecondaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30)),
                                          minimumSize: Size(getProportionateScreenWidth(350), getProportionateScreenHeight(60)),
                                        ),

                                        onPressed: (){
                                          // print('Enail : $email');
                                          // print('firstName : $firstName');
                                          // print('lastName : $lastName');
                                          // print('phone : $phone');
                                          // print('address : $address');
                                          if (_formKey.currentState!.validate()) {
                                            _formKey.currentState!.save();
                                            updateProfile();
                                          }else{
                                            print('validate false');
                                          }

                                        },
                                        child: Text("บันทึก",style: TextStyle(fontSize: getProportionateScreenWidth(18),color: Colors.white),))
                                  ],
                                ))
                          ]),
                    )),
              )),
        );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      readOnly: true,
      controller: TextEditingController(text: email),
      onChanged: (value) => {email = value.trim()},
      validator: (value) {
        if (value.toString().isEmpty) {
          return "กรุณากรอกอีเมล์"; //
        } else if (!emailValidatorRegExp.hasMatch(value.toString())) {
          return "กรุณากรอกอีเมล์ให้ถูกต้อง";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'อีเมล์',
        hintText: 'กรุณากรอกอีเมล์', //กรุณากรอกรหัสพนักงาน
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurfixIcon(
          press: () {},
          svgIcon: "assets/icons/Mail.svg",
        ),
      ),
    );
  }

  TextFormField buildFNameFormField() {
    return TextFormField(
      controller: TextEditingController(text: firstName),
      onChanged: (value) => {firstName = value.trim()},
      validator: (value) {
        if (value.toString().isEmpty) {
          return "กรุณากรอกชื่อ"; //
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'แก้ไขชื่อ',
        hintText: 'กรุณากรอกชื่อ', //กรุณากรอกรหัสพนักงาน
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurfixIcon(
          press: () {},
          svgIcon: "assets/icons/User Icon.svg",
        ),
      ),
    );
  }

  TextFormField buildLNameFormField() {
    return TextFormField(
      controller: TextEditingController(text: lastName),
      onChanged: (value) => {lastName = value.trim()},
      validator: (value) {
        if (value.toString().isEmpty) {
          return "กรุณากรอกชื่อ"; //
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'แก้ไขนามสกุล',
        hintText: 'กรุณากรอกนามสกุล', //กรุณากรอกรหัสพนักงาน
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurfixIcon(
          press: () {},
          svgIcon: "assets/icons/User Icon.svg",
        ),
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      controller: TextEditingController(text: phone),
      onChanged: (value) => {phone = value.trim()},
      validator: (value) {
        if (value.toString().isEmpty) {
          return "กรุณากรอกเบอร์โทร"; //
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'แก้ไขเบอร์โทร',
        hintText: 'กรุณากรอกเบอร์โทร', //กรุณากรอกรหัสพนักงาน
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurfixIcon(
          press: () {},
          svgIcon: "assets/icons/Phone.svg",
        ),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      maxLines: 3,
      controller:
          TextEditingController(text: address ?? ""),
      onChanged: (value) => {address = value.trim()},
      validator: (value) {
        if (value.toString().isEmpty) {
          return "กรุณากรอกที่อยู่"; //
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'แก้ไขที่อยู่',
        hintText: 'กรุณากรอกที่อยู่', //กรุณากรอกรหัสพนักงาน
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurfixIcon(
          press: () {},
          svgIcon: "assets/icons/Location point.svg",
        ),
      ),
    );
  }

  Future<void> updateProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('userID');
    var provider = Provider.of<JobUerProfileProvider>(context, listen: false);
    print("EditProfile userID = $userID");
    String url = 'http://61.7.142.47:8086/sfi-hr/select_job_user_profile.php?user_id=$userID';
    try{
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      if(result != null && result.toString() != '[]'){
        print("result = $result");
        for(var map in result){
          JobUserProfileModel jobUserProfileModel = JobUserProfileModel.fromJson(map);
          provider.addJobUserProfile(jobUserProfileModel);
        }
      }

    }catch(e){
      print("error = $e");
    }

  }



  Future<void> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('userID');

    print("EditProfile userID = $userID");
    String url = 'http://61.7.142.47:8086/sfi-hr/select_job_user_profile.php?user_id=$userID';
    try{
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      if(result != null && result.toString() != '[]'){
        print("result = $result");
        for(var map in result){
          JobUserProfileModel jobUserProfileModel = JobUserProfileModel.fromJson(map);
          setState(() {
            firstName = jobUserProfileModel.fIRSTNAME;
            lastName = jobUserProfileModel.lASTNAME;
            email = jobUserProfileModel.eMAIL;
            phone = jobUserProfileModel.pHONE;
            address = jobUserProfileModel.aDDRESS;
          });
        }
      }

    }catch(e){
      print("error = $e");
    }

  }


  Future<void> updateProfile() async{
    String url = 'http://61.7.142.47:8086/sfi-hr/updateJobProfile.php';
    try{
      var fromData = FormData.fromMap({
        "user_id": userID,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "address": address,
      });

      Response response = await Dio().post(url,data: fromData);
      print("response = $response");
      if(response.toString() == 'true'){
        print("update success");
        showDialog(context: context, builder: (context) => AlertDialog(
          title:  Text("อัพเดทข้อมูลสำเร็จ"),
          content: Icon(Icons.check_circle_outline_outlined,color: Colors.green,size: 100,),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                maximumSize: Size(100, 50),
              ),
              onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
                updateProvider();
                //Navigator.pushNamed(context, JobProfile.routName

              },
              child: const Text("ตกลง"),
            )
          ],
        ));
      }else{
        print("update fail");
      }
    // ignore: empty_catches
    }catch(e){
    }
  }


}
