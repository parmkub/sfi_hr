// ignore_for_file: avoid_print, empty_catches

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sfiasset/model/job_blank_model.dart';
import 'package:sfiasset/screens/jobEntry/job_detail_screen/job_detail_screen.dart';
import 'package:sfiasset/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Actions {delete,edit}

class BodyJobMy extends StatefulWidget {
  const BodyJobMy({super.key});



  @override
  State<BodyJobMy> createState() => _BodyJobMyState();
}

class _BodyJobMyState extends State<BodyJobMy> {
  List<JobBlankModel> jobBlankModel = [];
  bool loadData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyJob();
  }

  @override
  Widget build(BuildContext context) {

    return loadData ? jobBlankModel.isNotEmpty ?  RefreshIndicator(onRefresh: getMyJob, child: ListView.builder(
        itemCount: jobBlankModel.length,
        itemBuilder: (context, index) {
          return Slidable(
              key: ValueKey(jobBlankModel[index].jOBID),
              startActionPane:  ActionPane(
                extentRatio: 0.28,
                motion:  const BehindMotion(),
                dismissible: DismissiblePane(
                    onDismissed: ()=>_onDismissed(index)
                ),
                children: [
                  SlidableAction(
                    backgroundColor: Colors.redAccent,
                      icon: Icons.delete,
                      foregroundColor: Colors.white,
                      label: 'ลบ',
                      onPressed: (context){
                        _onDismissed(index);
                      }),
                ],),
              endActionPane: ActionPane(
                extentRatio: 0.28,
                motion:  const BehindMotion(),
                children: [
                  SlidableAction(
                      backgroundColor: Colors.greenAccent,
                      icon: Icons.document_scanner_outlined,
                      foregroundColor: Colors.white,
                      label: 'ดู',
                      onPressed: (context){
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context)=>JobDetailScreen(jobBlankModel: jobBlankModel[index],showButtonSubmit: false,),),);
                      }),
                ],),

              child:  Card(
                  elevation: 5,
                  color: Colors.white,
                  child: ListTile(
                    leading: Image.asset(logo(jobBlankModel[index].fACTORYNAME.toString()),width: getProportionateScreenWidth(50),height: getProportionateScreenHeight(50),),
                    title: Text("ตำแหน่ง:${jobBlankModel[index].jOBNAME}",style: TextStyle(fontSize: getProportionateScreenWidth(14)),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("เงินเดือน: ${jobBlankModel[index].jOBPRICE}",style: TextStyle(fontSize: getProportionateScreenWidth(12)),),
                        statusConvert(jobBlankModel[index].myJOBSTATUS.toString()),
                      ],
                    ),
                  ),
                ),
              );
        })): Center(
      child: Text('ท่านยังไม่ได้สมัครงาน',style: TextStyle(fontSize: getProportionateScreenWidth(18)),),
    ):showProgress();
  }

  Future<void> getMyJob() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString("userID");
    loadData = false;
    jobBlankModel.clear();
    print("user_id = $userId");

    String url = "http://61.7.142.47:8086/sfi-hr/select_my_job.php?user_id=$userId";
    Response response = await Dio().get(url);

    try {
      var result = jsonDecode(response.data);
      //print("result = $result");
      if (result != null) {
        for (var map in result) {
          JobBlankModel jobblank = JobBlankModel.fromJson(map);
          setState(() {
            jobBlankModel.add(jobblank);
            loadData = true;
          });
        }
      }
    } catch (e) {
      print(e);
    }

  }


  Future<void> _onDismissed(int index) async{
    final job = jobBlankModel[index];
    print('job_ID: ${job.jOBID}');
    String url = "http://61.7.142.47:8086/sfi-hr/DeleteMyJob.php?job_id=${job.jOBID}";
    Response response = await Dio().get(url);
    try{
      if(response.toString() == 'true'){
        print('ลบข้อมูลสำเร็จ');
        setState(() {
          jobBlankModel.removeAt(index);
          _showSnackBar(context, '${job.jOBNAME} is deleted',Colors.redAccent);

        });

      }else{
        print('ลบข้อมูลไม่สำเร็จ');
        getMyJob();
      }

    }catch(e){
      print( "ลบข้อมูลงานของตัวเองไม่ได้ Error: $e");
    }


  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(content: Text(message),backgroundColor: color,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Text statusConvert(String status) {
    Text text;
    if(status == '1'){
      text = Text('สถาน่ะ: รอเรียกตัว',style: TextStyle(fontSize: getProportionateScreenWidth(14),color: Colors.yellowAccent),);
    }else if(status == '2'){
      text = Text('สถาน่ะ: ท่านได้งานแล้ว',style: TextStyle(fontSize: getProportionateScreenWidth(14),color: Colors.green),);
    }else if(status == '3'){
      text = Text('สถาน่ะ: ท่านไม่ผ่านการคัดเลือก',style: TextStyle(fontSize: getProportionateScreenWidth(14),color: Colors.redAccent),);
    }else{
      text = Text('สถาน่ะ: รอดำเนินการ',style: TextStyle(fontSize: getProportionateScreenWidth(14),color: Colors.black),);
    }
    return text;
  }
  
  String logo(String businessName){
    String logo;
    if(businessName == 'sfi'){
      logo = "assets/images/logo.png";
    }else{
      logo = "assets/images/sff_logo.png";
    }
    return logo;
  }

}
