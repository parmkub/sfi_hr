// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constans.dart';
import '../../../model/employee_model.dart';
import '../../../size_config.dart';

class BodyCard extends StatefulWidget {
  const BodyCard({Key? key}) : super(key: key);

  @override
  State<BodyCard> createState() => _BodyCardState();
}

class _BodyCardState extends State<BodyCard> {
  static String? empCode,
      name,
      positionName,
      diviName,
      departName,
      sectName,
      sectCode;
  static String? bgImage;

  bool statusLoad = true;

  @override
  void initState() {
    getDataUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        statusLoad
            ? showProgress()
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      FrontCard(),
                      BackCard(),
                    ],
                  ),
                ),
              )
      ],
    );
  }

  Future<void> getDataUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String _empCode = preferences.getString('empcode')!;
    String url =
        "http://61.7.142.47:8086/sfi-hr/select_data_employee.php?empcode=$_empCode";
    Response response = await Dio().get(url);
    try {
      var result = jsonDecode(response.data);
      print(result);
      setState(() {
        statusLoad = false;
      });
      if (result != null) {
        for (var map in result) {
          EmployeeModel EmployeeData = EmployeeModel.fromJson(map);

          setState(() {
            name = EmployeeData.nAME.toString();
            positionName = EmployeeData.pOSITIONNAME.toString();
            departName = EmployeeData.dEPARTNAME.toString();
            diviName = EmployeeData.dIVINAME.toString();
            if (diviName == 'null') {
              diviName = '';
            }
            sectName = EmployeeData.sECTNAME.toString();
            if (sectName == 'null') {
              sectName = '';
            }
            sectCode = EmployeeData.sECTCODE.toString();
            if (sectCode == 'null') {
              sectCode = '';
            }

            if (EmployeeData.nATIONALITYCODE.toString() == "TH") {
              bgImage = "assets/images/emp_chp3.jpg";
            } else if (EmployeeData.nATIONALITYCODE.toString() == "B") {
              bgImage = "assets/images/emp_chp1.jpg";
            } else if (EmployeeData.nATIONALITYCODE.toString() == "K") {
              bgImage = "assets/images/emp_chp2.jpg";
            } else {
              bgImage = "assets/images/emp_chp4.jpg";
            }
          });
        }
      }
    } catch (e) {}

    empCode = '${preferences.getString('empcode')!.substring(0, 2)}-${preferences.getString('empcode')!.substring(2)}';
  }

  Widget FrontCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: const EdgeInsets.all(10.0),
      elevation: 20,
      child: Container(
        width: double.infinity,
        height: getProportionateScreenHeight(710),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: AssetImage(bgImage.toString()),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                height: getProportionateScreenHeight(150),
              ),
              ImageDrower(),
              /* Image.network(
                        'http://61.7.142.47:8086/img/sfi/' + empCode! + '.jpg',
                        width: getProportionateScreenWidth(140.0),
                        height: getProportionateScreenHeight(140.0),
                      ),*/
              SizedBox(
                width: double.infinity,
                child: Text(
                  name.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(18.0),
                      color: kTextColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                positionName.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(18.0),
                    color: kTextColor),
              ),
              sectName == ''
                  ? const SizedBox()
                  : Text(
                      sectName.toString() + sectCode.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(18.0),
                          color: kTextColor),
                    ),
              diviName == ''
                  ? const SizedBox()
                  : Text(
                      "ส่วน" + diviName.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(18.0),
                          color: kTextColor),
                    ),
              Text(
                departName.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(18.0),
                    color: kTextColor),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              BarcodeWidget(
                backgroundColor: Colors.white,
                data: empCode!.substring(0, 2).toString() +
                    empCode!.substring(3).toString(),
                barcode: Barcode.code128(),
                width: getProportionateScreenWidth(300),
                height: getProportionateScreenHeight(100),
                drawText: true,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                errorBuilder: (context, error) => Center(
                    child: Text(
                  error.toString(),
                  style: const TextStyle(color: Colors.red),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget BackCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: const EdgeInsets.all(10.0),
      elevation: 20,
      child: Container(
        width: double.infinity,
        height: getProportionateScreenHeight(710),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "นโยบายคุณภาพ",
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(20),
                      color: kTextColor,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "มุ่งคุณภาพ",
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(20),
                          color: kTextColor),
                    ),
                    Text(
                      " อาหารปลอดภัย",
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(20),
                          color: kTextColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ใส่ใจพนักงาน",
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(20),
                          color: kTextColor),
                    ),
                    Text(
                      " ส่งมอบทันเวลา",
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(20),
                        color: kTextColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "รักษาสิ่งแวดล้อม",
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(20),
                          color: kTextColor),
                    ),
                    Text(
                      " ปฏิบัติตามกฎหมาย",
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(20),
                        color: kTextColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "พัฒนาอย่างต่อเนื่อง",
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(20),
                      color: kTextColor),
                ),
                const SizedBox(),
                Text(
                  "ข้อปฏิบัติ",
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(20),
                      color: kTextColor,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "1.บัตรนี้ใช้เฉพาะผู้มีชื่อเป็นเจ้าของบัตรเท่านั้น",
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(20),
                            color: kTextColor),
                      ),
                      Text(
                        "2.แสดงบัตรทุกครั้งที่ติดต่อกับหน่วยงานของบริษัท",
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(20),
                            color: kTextColor),
                      ),
                      Text(
                        "3.บัตรหายหรือชำรุดแจ้งส่วนงานสารสนเทศงานบุคคลเพื่อทำบัตรใหม่",
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(20),
                            color: kTextColor),
                      ),
                      Text(
                        "4.ผู้ใดเก็บบัตรได้ ให้ส่งส่วนงานสารสนเทศงานบุคคล",
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(20),
                            color: kTextColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        "บริษัท ซีเฟรชอินดัสตรี จำกัด (มหาชน)",
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(20),
                            color: kTextColor),
                      ),
                      Text(
                        "ที่อยู่ 402 หมู่ 8 ตำบล ปากน้ำ อำเภอ เมือง ",
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(20),
                            color: kTextColor),
                      ),
                      Text(
                        "จังหวัด ชุมพร 86120",
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(20),
                            color: kTextColor),
                      ),
                      Text(
                        "โทรศัพท์ 077-521321-3",
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(20),
                            color: kTextColor),
                      ),
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }

  Widget ImageDrower() {
    return SizedBox(
      width: getProportionateScreenHeight(120),
      child: FadeInImage(
        placeholder: const AssetImage("assets/images/userProfile.png"),
        image: NetworkImage(
            "http://61.7.142.47:8086/img/sfi/" + empCode.toString() + ".jpg"),
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset("assets/images/userProfile.png");
        },
        fit: BoxFit.cover,
      ),
    );
  }
}
