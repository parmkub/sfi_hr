// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sfiasset/components/normal_dialog.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/model/job_blank_model.dart';
import 'package:sfiasset/screens/jobEntry/job_sign_in/job_sign_in_screen.dart';
import 'package:sfiasset/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BodyJobDetail extends StatefulWidget {
  final JobBlankModel jobBlankModel;
  final bool showButtonSubmit;
  const BodyJobDetail({super.key, required this.jobBlankModel, required this.showButtonSubmit});

  @override
  State<BodyJobDetail> createState() => _BodyJobDetailState();
}

class _BodyJobDetailState extends State<BodyJobDetail> {
  String email = "";
  String name = "";
  String phone = "";
  String position = "";

  String? userID;

  String? jobId;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          gradient: kBackgroundColor,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Image(
                image: jobLogo(widget.jobBlankModel.fACTORYNAME.toString()),
                width: getProportionateScreenWidth(80),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            factoryName(widget.jobBlankModel.fACTORYNAME.toString()),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                color: kPrimaryColor,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "ตำแหน่ง: ${widget.jobBlankModel.jOBNAME}",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )

                ),
              ),
            ),

            Card(
              child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text('รายละเอียดของงาน', style: TextStyle(
                                  fontSize: getProportionateScreenWidth(14),
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),)
                          ),
                          Text('ประเภทธุรกิจ ${widget.jobBlankModel.bUSINESSTYPE ?? ''}',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(14),
                                fontWeight: FontWeight.bold),),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text('เกี่ยบกับบริษัท', style: TextStyle(
                                    fontSize: getProportionateScreenWidth(12),
                                    fontWeight: FontWeight.bold)),),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  '${widget.jobBlankModel.bUSINESSABOUT ?? ''} ',
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(14),),
                                ),)


                            ],
                          ),
                          jobDetail(
                              'สาขาหลัก', '${widget.jobBlankModel.jOBMAJOR}'),
                          jobDetail('สาขารอง',
                              '${widget.jobBlankModel.jOBMAJORSECOUND}'),
                          jobDetail('ทำงานที่',
                              '${widget.jobBlankModel.jOBLOCATION}'),
                          jobDetail(
                              'ตำแหน่ง', '${widget.jobBlankModel.jOBPOSITION}'),
                          jobDetail(
                              'จำนวน', '${widget.jobBlankModel.jOBQUATITIY}'),

                          jobDetail(
                              'เงินเดือน', '${widget.jobBlankModel.jOBPRICE}'),
                          jobDetail(
                              'วันหยุด', '${widget.jobBlankModel.jOBHOLIDAY}'),
                          jobDetail('เวลาทำงาน',
                              '${widget.jobBlankModel.jOBWORKTIME}'),
                          jobDetail(
                              'อื่นๆ', '${widget.jobBlankModel.jOBOTHER}'),
                        ]
                    ),
                  )
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Card(
              child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text('คุณสมบัติ', style: TextStyle(
                                  fontSize: getProportionateScreenWidth(14),
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),)
                          ),
                          jobDetail('การศึกษา',
                              '${widget.jobBlankModel.dEGREE}'),
                          jobDetail('เพศ', '${widget.jobBlankModel.jOBGENDER}'),
                          jobDetail('อายุ', '${widget.jobBlankModel.jOBAGE}'),
                          jobDetail(
                              'ประสบการ', '${widget.jobBlankModel.jOBEXP}'),
                        ]
                    ),
                  )
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Card(
              child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text('คุณสมบัติความรู้และความสามารถ',
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(14),
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor),)
                          ),
                          Html(
                            data: '${widget.jobBlankModel.jOBDETAIL}',
                            style: {
                              "body": Style(
                                fontSize: FontSize(
                                    getProportionateScreenWidth(14)),
                              ),
                            },),
                        ]
                    ),
                  )
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Card(
              child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text('สวัสดิการ', style: TextStyle(
                                  fontSize: getProportionateScreenWidth(14),
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),)
                          ),
                          Html(
                            data: '${widget.jobBlankModel.jOBWELFARE}', style: {
                            "body": Style(
                              fontSize: FontSize(
                                  getProportionateScreenWidth(14)),
                            ),
                            "ul": Style(
                              textAlign: TextAlign.left,
                            ),
                          },),
                        ]
                    ),
                  )
              ),
            ),

            const SizedBox(
              height: 5,
            ),
            Card(
              child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text('วิธีการสมัคร', style: TextStyle(
                                  fontSize: getProportionateScreenWidth(14),
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),)
                          ),
                          Text('-สมัครทาง application sfi-hr', style: TextStyle(
                              fontSize: getProportionateScreenWidth(14),
                              fontWeight: FontWeight.bold),),
                          Text('-Email: HR@sefreh.con', style: TextStyle(
                              fontSize: getProportionateScreenWidth(14),
                              fontWeight: FontWeight.bold),),
                        ]
                    ),
                  )
              ),
            ),
            SizedBox(
              height: 5,
            ),
            widget.showButtonSubmit? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  showDialog(context: context, builder: (context) =>
                      AlertDialog(
                        title: Text("สมัครงาน", style: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),),
                        content: Builder(
                          builder: (context) {
                            return SizedBox(
                              width: double.infinity,
                              height: getProportionateScreenHeight(100),
  
                              child: Column(
                                children: [
                                  Text("คุณต้องการสมัครงานตำแหน่ง ${widget.jobBlankModel.jOBNAME} ใช่หรือไม่", style: TextStyle(
                                      fontSize: getProportionateScreenWidth(14),
                                      fontWeight: FontWeight.bold),),
                                  SizedBox(height: 20,),

                                ],
                              ),
                            );
                          },
                        ),
                        actions: [
                          TextButton(onPressed: () {

                            registerJob ();
                          }, child: Text("ตกลง",style: TextStyle(color: Colors.green,fontSize: getProportionateScreenWidth(16)),)),
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text("ยกเลิก", style: TextStyle(color: Colors.red,fontSize: getProportionateScreenWidth(16)),))
                        ],
                      ));
                },
                child: Text("สมัครงาน")):
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Future<void> registerJob () async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
      userID = preferences.getString('userID');
      jobId = widget.jobBlankModel.jOBID;
      print("userID: $userID");
      //print("jobID: $jobId");
      if(userID == null || userID == '' || userID == 'null') {
        Navigator.pop(context);
        normalDialogNavigator(context, 'ท่านต้องล๊อกอินเข้าระบบก่อน', Icons.warning_rounded, Colors.yellow, JobSignInScreen.routName);

      } else {
        String url = 'http://61.7.142.47:8086/sfi-hr/checkJobDupicate.php?job_id=$jobId&user_id=$userID';
        var response = await Dio().get(url);
        print(response.data.toString());
        if (response.data.toString() == 'true') {
          Navigator.pop(context);
          normalDialog(context, 'ท่านได้สมัครงานนี้ไปแล้ว กรุณาตรวจสอบสถานะที่งานของฉัน', Icons.warning_rounded, Colors.yellow);
        } else {
          String url = 'http://61.7.142.47:8086/sfiblog/regisJob.php';
          var fromData = FormData.fromMap({
            "userID": userID,
            "jobID": jobId,
            "status": "0",
          });

          try {
            var response = await Dio().post(url, data: fromData);
            if (response.statusCode == 200) {
              print(response.data.toString());
              if (response.data.toString() == 'true') {
                // Navigator.pushNamed(context, HomeScreen.routeName);
                showDialog(context: context, builder: (context) =>
                    AlertDialog(
                      title: Text("สมัครงานสำเร็จ", style: TextStyle(
                          fontSize: getProportionateScreenWidth(14),
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),),
                      content: Builder(
                        builder: (context) {
                          return SizedBox(
                            width: getProportionateScreenWidth(300),
                            height: getProportionateScreenHeight(200),
                            child: Column(
                              children: [
                                Icon(Icons.check_circle, color: Colors.green,
                                  size: getProportionateScreenWidth(100),),
                                SizedBox(height: 10,),
                                Text("คุณสมัครงาน ${widget.jobBlankModel
                                    .jOBNAME} สำเร็จ", style: TextStyle(
                                    fontSize: getProportionateScreenWidth(14),
                                    fontWeight: FontWeight.bold,
                                    color: kTextColor),),
                                SizedBox(height: 20,),

                              ],
                            ),
                          );
                        },
                      ),
                      actions: [
                        TextButton(onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                            child: Text("ตกลง", style: TextStyle(
                                color: Colors.green,
                                fontSize: getProportionateScreenWidth(16)),)),
                      ],
                    ));
              } else {
                print('error');
              }
            }
          } catch (e) {
            print(e);
          }
        }
      }
  }

  Widget jobDetail(String title, String detail) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(title, style: TextStyle(
              fontSize: getProportionateScreenWidth(14),
              fontWeight: FontWeight.bold),),),
        Expanded(
          flex: 3,
          child: Text(detail,
            style: TextStyle(fontSize: getProportionateScreenWidth(14)),),)
      ],
    );
  }

  AssetImage jobLogo(String factoryName) {
    String image = "";
    if (factoryName == "sfi") {
      image = "assets/images/logo.png";
    } else if(factoryName == "sff"){
      image = "assets/images/sff_logo.png";
    }else{
      image = "assets/images/userProfile.png";
    }
    return AssetImage(image);
  }

  Text factoryName(String facetoryName) {
    String name = "";
    if (facetoryName == "sfi") {
      name = "บริษัซีเฟรชอินดัสตรีจำกัด มหาชน";
    } else if (facetoryName == "sff") {
      name = "บริษัทซีเฟรชฟาร์ม จำกัด";
    }

    return Text(name, style: TextStyle(
        fontSize: getProportionateScreenWidth(16),
        fontWeight: FontWeight.bold),);
  }
}
