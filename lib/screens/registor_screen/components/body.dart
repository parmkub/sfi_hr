
// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:bcrypt/bcrypt.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/components/custom_surfix_icon.dart';
import 'package:sfiasset/components/normal_dialog.dart';

import 'package:sfiasset/constans.dart';
import 'package:sfiasset/screens/sign_in/sign_in_screen.dart';
import 'package:sfiasset/size_config.dart';

class Body extends StatefulWidget {
  final String username;
  final String empCode;
  final String name;

  const Body({super.key, required this.username, required this.empCode, required this.name});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String empCode = "";

  var userName = "", name = "";

  bool passwordVisable = true;
  bool passwordAgainVisable = true;

  String password = "";
  String passwordAgain = "";

  String email = "";

  final formKey = GlobalKey<FormState>();


  @override
  void initState() {
    userName = widget.username;
    name = widget.name;
    empCode = widget.empCode;

/*    print("Username = ${widget.username}");
    print("name = $name");
    print("empCode = $empCode");*/
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: GestureDetector(
          onTap: () => FocusScope.of(context)
              .requestFocus(FocusNode()), //คลิ๊กตรงไหนก็ได้เพื่อเก็บ keybord
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: getProportionateScreenWidth(10)
                      ),
                      /*Text(
                        AppLocalizations.of(context).translate('register'), //ลงทะเบียน
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold),
                      ),*/
                      SizedBox(
                        height: getProportionateScreenWidth(30)
                      ),
                      ImageProfile(empCode),
                      SizedBox(
                        height: getProportionateScreenWidth(10)
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20),
                          vertical: getProportionateScreenWidth(15),
                        ),
                        decoration: BoxDecoration(

                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.black),
                        ),
                        child:  Text("${AppLocalizations.of(context).translate('empCode')} :$empCode",style: TextStyle(fontSize: getProportionateScreenWidth(14)),),
                      ),
                      SizedBox(
                          height: getProportionateScreenWidth(10)
                      ),

                /*      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20),
                          vertical: getProportionateScreenWidth(15),
                        ),
                        decoration: BoxDecoration(

                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.black),
                        ),
                        child:  Text("Username : $Username",style: TextStyle(fontSize: getProportionateScreenWidth(14)),),
                      ),*/
                      SizedBox(
                          height: getProportionateScreenWidth(10)
                      ),
                      Form(
                          key: formKey,
                          child: Column(children: [
                            buildPassFormField(),
                            SizedBox(
                              height: getProportionateScreenWidth(10),
                            ),
                            buildPassAgainFormField(),
                            SizedBox(
                              height: getProportionateScreenWidth(10),
                            ),
                            buildEmailFormField(),
                            SizedBox(
                              height: getProportionateScreenWidth(20),
                            ),
                            TextButton(onPressed: (){
                              if(formKey.currentState!.validate()){
                        /*        print("Username = $userName");
                                print("empCode = $empCode");
                                print("name = $name");
                                print("password = $password");
                                print("passwordAgain = $passwordAgain");
                                print("email = $email");*/

                                if(password == passwordAgain){

                                  Register();

                                }else{
                                  normalDialog(context, AppLocalizations.of(context).translate('passwordNotMatch'),Icons.error_outline_outlined,Colors.red); //รหัสผ่านไม่ตรงกัน
                                }
                              }
                            },
                              style: TextButton.styleFrom(

                                  backgroundColor: kPrimaryColor,
                                  minimumSize: const Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  )),
                              child: Text(AppLocalizations.of(context).translate('register'),style: TextStyle(color: Colors.white,fontSize: getProportionateScreenWidth(18)),),)
                          ]))
                    ],
                  ),
                )),
          )),
    );
  }

  Future<void> Register() async {
    print("userName>>>>>>>>>>>>$userName");
    String url = "http://61.7.142.47:8086/sfi-hr/RegisterUser.php";
    var fromData = FormData.fromMap({
      "empCode": empCode,
      "nAme": userName,
      "passAuthen": BCrypt.hashpw(password, BCrypt.gensalt()),
      "email": email,
    });
    await Dio().post(url, data: fromData).then((value) {
      print("res = $value");
      if (value.toString() == "true") {
        //normalDialog(context, AppLocalizations.of(context).translate('registerSuccess')); //่ลงทะเบียนสำเร็จ

        showDialog(context: context, builder: (context)=>SimpleDialog(
          title: Text(AppLocalizations.of(context).translate('registerSuccess')), //ลงทะเบียนสำเร็จ
          children: <Widget>[
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                    Icons.question_answer_rounded,
                    size: 50,
                    color: kPrimaryColor
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, SignInScreen.routName);
                  },
                  child:  Text(
                    'OK',
                    style: TextStyle(fontSize: getProportionateScreenWidth(18)),
                  ),
                )

              ],
            )

          ],
        ));

      } else {
        normalDialog(context, AppLocalizations.of(context).translate('registerFail'),Icons.error_outline_outlined,Colors.red); //ลงทะเบียนไม่สำเร็จ
      }
    });
  }

  Container ImageProfile(String empCode) {
    String empCodeConver = "${empCode.substring(0,2)}-${empCode.substring(2,6)}";
    //print("empCodeConver = $empCodeConver");
    return Container(
      width: getProportionateScreenWidth(120),
      height: getProportionateScreenWidth(120),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black),
      ),
      child: ClipOval(

        child: FadeInImage(

          placeholder:
          const AssetImage("assets/images/userProfile.png"),
          image: NetworkImage(
              "http://61.7.142.47:8086/img/sfi/$empCodeConver.jpg",scale:2,),
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset("assets/images/userProfile.png",
                fit: BoxFit.cover);
          },

          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      onChanged: (value) => {empCode = value},
      validator: (value) {
        if (value.toString().isEmpty) {
          return AppLocalizations.of(context).translate('PleaseEnterEmpcode'); //กรุณากรอกรหัสพนักงาน
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).translate('empcode'),
        hintText: AppLocalizations.of(context).translate('PleaseEnterEmpcode'), //กรุณากรอกรหัสพนักงาน
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
          return AppLocalizations.of(context).translate('PleaseEnterPassword'); //กรุณากรอกรหัสผ่าน
        }
        return null;
      },
      obscureText: passwordVisable,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).translate('password'),
        hintText: AppLocalizations.of(context).translate('PleaseEnterPassword'), //กรุณากรอกรหัสผ่าน
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: PasswordVisableButton(),
      ),
    );
  }

  TextFormField buildPassAgainFormField() {
    return TextFormField(
      onChanged: (value) => {passwordAgain = value.trim()},
      validator: (value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context).translate('confirmPassword'); //กรุณากรอกรหัสผ่านอีกครั้ง
        }
        return null;
      },
      obscureText: passwordAgainVisable,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).translate('confirmPassword'),
        hintText: AppLocalizations.of(context).translate('confirmPassword'), //กรุณากรอกรหัสผ่านอีกครั้ง
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: PasswordAgainVisableButton(),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      onChanged: (value) => {email = value.trim()},
      validator: validateEmail,
      obscureText: false,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).translate('email'),
        hintText: AppLocalizations.of(context).translate('typeEmail'), //อีเมล
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconKey(Icons.email),
      ),
    );
  }

  Padding IconKey(IconData iconData) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
      ),
      child: Icon(iconData,
          size: getProportionateScreenWidth(16.0), color: kTextColor),
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

  Padding PasswordAgainVisableButton() {
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
            passwordAgainVisable = !passwordAgainVisable;
          });
        },
        icon: Icon(
          passwordAgainVisable ? Icons.visibility_off : Icons.visibility,
          size: getProportionateScreenWidth(16.0),
          color: kTextColor,
        ),
      ),
    );
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? AppLocalizations.of(context).translate('PleaseEnterValidEmail') //กรุณากรอกอีเมลที่ถูกต้อง
        : null;
  }
}
