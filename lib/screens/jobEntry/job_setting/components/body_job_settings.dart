import 'package:bcrypt/bcrypt.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/components/default_buttom.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BodyJobSettings extends StatefulWidget {
  const BodyJobSettings({super.key});

  @override
  State<BodyJobSettings> createState() => _BodyJobSettingsState();
}

class _BodyJobSettingsState extends State<BodyJobSettings> {

  final _formKey = GlobalKey<FormState>();
  String? passwordOld, passwordNew, passwordNewConfirm;

  var passwordVisable = true;



  var passwordNewConfirmVisable = true;
  var passwordNewVisable = true;

  String? perferencePasswordOld;

  String? userID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPerferences();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
          gradient: kBackgroundColor
        ),
          width: double.infinity,
        height: SizeConfig.screenHeight,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(height: getProportionateScreenHeight(10),),
              Text('เปลี่ยนรหัสผ่าน',style: TextStyle(fontSize: getProportionateScreenWidth(18),fontWeight: FontWeight.bold),),
              SizedBox(height: getProportionateScreenHeight(20),),
              buildPassOldFormField(),
              SizedBox(height: getProportionateScreenHeight(20),),
              buildPassNewFormField(),
              SizedBox(height: getProportionateScreenHeight(20),),
              buildPassNewConfrimFormField(),
              SizedBox(height: getProportionateScreenHeight(100),),
              DefaultButton(
                text: 'บันทึก',
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print(passwordOld);
                    print(passwordNew);
                    print(passwordNewConfirm);
                    if(passwordNew == passwordNewConfirm){
                      print('password match');
                      if(BCrypt.checkpw(passwordOld!, perferencePasswordOld!)) {
                        updatePassword();
                        print('update Password');
                      }else{
                        print('password old not match');
                      }
                    }else{
                      print('password not match');
                    }
                  }
                },
              ),

            ],

          ),
        )),
      ));
  }

  Future<void> getPerferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      perferencePasswordOld = preferences.getString('password');
      userID = preferences.getString('userID');
      print('passwordOldSharePerFerence = $perferencePasswordOld');
    });
  }

  Future<void> updatePassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('password', BCrypt.hashpw(passwordNew!, BCrypt.gensalt()));


    String url = "http://61.7.142.47:8086/sfi-hr/updatePasswordJob.php";

    var formData = FormData.fromMap({
      "password": BCrypt.hashpw(passwordNew!, BCrypt.gensalt()),
      "user_id": userID,
    });
    try{
      await Dio().post(url, data: formData).then((value) {
        print(value.data);
        if(value.data == 'true'){
          print('update password userID $userID success' );
          showDialog(context: context, builder: (context) => AlertDialog(
            title: const Text('อัพเดทรหัสผ่านเรียบร้อยแล้ว'),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
              }, child: Text('ตกลง',style: TextStyle(color: Colors.green,fontSize: getProportionateScreenWidth(14)),))
            ],
          ));
      } else{
          print('update password fail');
        }
      });
    }catch(e){
      print(e);
    }
  }


  TextFormField buildPassOldFormField() {
    return TextFormField(
      onChanged: (value) => {passwordOld = value.trim()},
      validator: (value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context).translate('PleaseEnterPassword'); //กรุณากรอกรหัสผ่าน
        }
        return null;
      },
      obscureText: passwordVisable,
      decoration: InputDecoration(
        labelText: 'รหัสผ่านเดิม',
        hintText: 'กรุณากรอกรหัสผ่านเดิม', //กรุณากรอกรหัสผ่าน
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: PasswordVisableButton(),
      ),
    );

  }

  TextFormField buildPassNewFormField() {
    return TextFormField(
      onChanged: (value) => {passwordNew = value.trim()},
      validator: (value) {
        if (value!.isEmpty) {
          return 'กรุณากรอกรหัสผ่านใหม่'; //กรุณากรอกรหัสผ่านอีกครั้ง
        }else if(value.toString() != passwordNewConfirm){
          return AppLocalizations.of(context).translate('passwordNotMatch'); //กรุณากรอกรหัสผ่าน
        }
        return null;
      },
      obscureText: passwordNewVisable,
      decoration: InputDecoration(
        labelText: 'รหัสผ่านใหม่',
        hintText: 'รหัสผ่านใหม่', //กรุณากรอกรหัสผ่านอีกครั้ง
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: PasswordNewVisableButton(),
      ),
    );
  }

  TextFormField buildPassNewConfrimFormField() {
    return TextFormField(
      onChanged: (value) => {passwordNewConfirm = value.trim()},
      validator: (value) {
        if (value!.isEmpty) {
          return 'กรุณากรอกรหัสผ่านใหม่'; //กรุณากรอกรหัสผ่านอีกครั้ง
        }else if(value.toString() != passwordNew){
          return AppLocalizations.of(context).translate('passwordNotMatch'); //กรุณากรอกรหัสผ่าน
        }
        return null;
      },
      obscureText: passwordNewConfirmVisable,
      decoration:  InputDecoration(
        labelText: 'กรุณากรอกรหัสผ่านใหม่อีกครั้ง',
        hintText: 'ยืนยันรหัสผ่านใหม่', //กรุณากรอกรหัสผ่านอีกครั้ง
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: PasswordNewConfrimVisableButton(),
      ),
    );
  }

  Padding PasswordVisableButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(12),
        getProportionateScreenWidth(12),
        getProportionateScreenWidth(12),
      ),
      child: IconButton(
        onPressed: () {
          setState(() {
            passwordVisable = !passwordVisable;
          });
        },
        icon: Icon(
          passwordVisable ? Icons.visibility_off : Icons.visibility,
          size: getProportionateScreenWidth(16.0),
          color: kTextColor,
        ),
      ),
    );
  }

  Padding PasswordNewVisableButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(12),
        getProportionateScreenWidth(12),
        getProportionateScreenWidth(12),
      ),
      child: IconButton(
        onPressed: () {
          setState(() {
            passwordNewVisable = !passwordNewVisable;
          });
        },
        icon: Icon(
          passwordNewVisable ? Icons.visibility_off : Icons.visibility,
          size: getProportionateScreenWidth(16.0),
          color: kTextColor,
        ),
      ),
    );
  }
  Padding PasswordNewConfrimVisableButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(12),
        getProportionateScreenWidth(12),
        getProportionateScreenWidth(12),
      ),
      child: IconButton(
        onPressed: () {
          setState(() {
            passwordNewConfirmVisable = !passwordNewConfirmVisable;
          });
        },
        icon: Icon(
          passwordNewConfirmVisable ? Icons.visibility_off : Icons.visibility,
          size: getProportionateScreenWidth(16.0),
          color: kTextColor,
        ),
      ),
    );
  }
}

