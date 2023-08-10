// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/components/normal_dialog.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/size_config.dart';

class BodyAppeal extends StatefulWidget {
  const BodyAppeal({Key? key}) : super(key: key);

  @override
  State<BodyAppeal> createState() => _BodyAppealState();
}

class _BodyAppealState extends State<BodyAppeal> {
  final _formKey = GlobalKey<FormState>();

  String? detail;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          decoration: const BoxDecoration(gradient: kBackgroundColor),
          width: double.infinity,
          height: SizeConfig.screenHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  AppLocalizations.of(context).translate('Appeal'),
                  style: TextStyle(fontSize:  getProportionateScreenWidth(14), fontWeight: FontWeight.bold),
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        TextFormField(
                          onSaved: (newValue) {
                            detail = newValue;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context).translate('Appeal_insert');
                            }
                            return null;
                          },
                          maxLines: 20,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).translate('Appeal_insert'),
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenWidth(20),),
                        TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              debugPrint('detail = $detail');
                              ShowDialog(context, AppLocalizations.of(context).translate('Appeal_Ask'));

                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
                          ),
                          child:  Text(
                            AppLocalizations.of(context).translate('Appeal_send'),
                            style: TextStyle(color: Colors.white,fontSize: getProportionateScreenWidth(14)),
                          ),
                        ),

                      ],
                    )
                ),
              ),


            ],
          )),
    );
  }

  Future<void> sendMail() async {
    String url = 'http://61.7.142.47:3002/appeal?reason=$detail';
    var response = await Dio().get(url);
   // debugPrint('response = $response');
    int resultStatus = response.data['RespCode'];
    debugPrint('resultStatus = $resultStatus');

    if (resultStatus == 200) {
      normalDialog(context, AppLocalizations.of(context).translate('Appeal_success'),Icons.check_circle_outline_rounded,Colors.green);
      _formKey.currentState!.reset();
    } else {
      normalDialog(context, AppLocalizations.of(context).translate('Appeal_fail'),Icons.error_outline_rounded,Colors.red);
    }

  }

  Future<void> InsetData() async {
    String url = 'http://61.7.142.47:8086/sfi-hr/insertAppeal.php';
    var formData = FormData.fromMap({
      'appeal': detail,
    });
    var response = await Dio().post(url, data: formData);
    debugPrint('response = $response');
     if (response.toString() == 'true') {
        normalDialog(context, AppLocalizations.of(context).translate('Appeal_success'),Icons.check_circle_outline_rounded,Colors.green);
        _formKey.currentState!.reset();
      } else {
        normalDialog(context, AppLocalizations.of(context).translate('Appeal_fail'),Icons.error_outline_rounded,Colors.red);
      }

  }

  Future<void> ShowDialog(BuildContext context, String message) async {
    showDialog(context: context, builder: (context)=>SimpleDialog(
      title: Text(message),
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // ignore: deprecated_member_use
            /*  FlatButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(fontSize: 18),
            ),
          )*/
            SizedBox(
                width: getProportionateScreenWidth(80),
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  //InsetData();
                  sendMail();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                child:  Text(
                  AppLocalizations.of(context).translate('yes'),
                  style: TextStyle(fontSize: getProportionateScreenWidth(14),color: Colors.white),
                )
            ),),
            const SizedBox(width: 10,),

            SizedBox(
              width: getProportionateScreenWidth(80),
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  child:  Text(
                    AppLocalizations.of(context).translate('no'),
                    style: TextStyle(fontSize: getProportionateScreenWidth(14),color: Colors.white),
                  )
              ),
            )

          ],
        )

      ],
    ));
  }
}
