import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/model/job_blank_model.dart';
import 'package:sfiasset/screens/jobEntry/job_detail_screen/job_detail_screen.dart';
import 'package:sfiasset/size_config.dart';

class BodyJob extends StatefulWidget {
  const BodyJob({super.key});

  @override
  State<BodyJob> createState() => _BodyJobState();
}

class _BodyJobState extends State<BodyJob> {
  List<JobBlankModel> jobBlankModel = [];
  bool loadData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJobBlank();
  }

  @override
  Widget build(BuildContext context) {
    return loadData? SafeArea(child: RefreshIndicator(
        onRefresh: getJobBlank,
        child: jobBlankModel.isNotEmpty ? Container(
            child: Column(
              children: [
                // Expanded(
                //     flex: 4,
                //     child: Container(
                //       child: CarouselSlider.builder(
                //         itemCount: 3,
                //         itemBuilder: (context, index, realIndex) {
                //           return GestureDetector(
                //               onTap: () {
                //                 // Navigator.pushNamed(context, JobDetailScreen.routName,
                //                 //     arguments: {'id': '1', 'name': 'name'});
                //               },
                //               child: SizedBox(
                //                 width: double.infinity,
                //                 child: Card(
                //                   elevation: 2,
                //                   child: Image(
                //                     image: AssetImage(
                //                         "assets/images/Splash${index + 1}.png"),
                //                   ),
                //                 ),
                //               ));
                //         },
                //         options: CarouselOptions(
                //           autoPlay: true,
                //           aspectRatio: 2.0,
                //           //enlargeCenterPage: true,
                //           enlargeStrategy: CenterPageEnlargeStrategy.height,
                //         ),
                //       ),
                //       // child: PageView.builder(
                //       //   controller: _pageController,
                //       //     itemCount: 3,
                //       //     itemBuilder: (context, index) {
                //       //       return  Card(
                //       //         elevation: 5,
                //       //         child: Image(
                //       //           image: AssetImage("assets/images/Splash${index+1}.png"),
                //       //         ),
                //       //
                //       //       );
                //       //     }),
                //     )),
                Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height:getProportionateScreenHeight(50),
                            child: Card(
                              color: kPrimaryColor,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('ตำแหน่งงานว่าง ${jobBlankModel.length} ตำแหน่ง',style: TextStyle(
                                    fontSize: getProportionateScreenHeight(18),color: Colors.white,fontWeight: FontWeight.bold
                                ),

                                ),),
                            ),
                          )

                        ],
                      ),
                    )),
                Expanded(
                  flex: 10,
                  child: ListView.builder(
                    itemCount: jobBlankModel.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            leading: Image(
                              width: getProportionateScreenWidth(50),
                              image: jobLogo(jobBlankModel[index].fACTORYNAME.toString()),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                factoryName(jobBlankModel[index].fACTORYNAME.toString()),
                                Text(
                                  '${jobBlankModel[index].jOBNAME}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: getProportionateScreenHeight(14)),
                                ),
                              ],
                            ),
                            subtitle:
                            Text('เงินเดือน: ${jobBlankModel[index].jOBPRICE}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: getProportionateScreenHeight(14))),
                            trailing: Column(

                              children: [

                                Text(timeStemp(jobBlankModel[index].dATEDIFF.toString()),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: getProportionateScreenHeight(14))),

                              ],

                            ),
                          ),
                        ),
                        onTap: () {
                          //print("index: $index");
                          MaterialPageRoute route = MaterialPageRoute(
                              builder: (value) => JobDetailScreen(
                                jobBlankModel: jobBlankModel[index],showButtonSubmit: true,));
                          Navigator.push(context, route);
                        },
                      );
                    },
                  ),
                )
              ],
            )): Center(child: Text('ไม่มีตำแหน่งงานที่เปิดรับสมัคร',style: TextStyle(fontSize: getProportionateScreenWidth(14)),),)
    )): Center(child: CircularProgressIndicator(),);
  }

  Future<void> getJobBlank() async {
    String url = "http://61.7.142.47:8086/sfiblog/selectJob.php";
    jobBlankModel.clear();
    loadData = false;


    Response response = await Dio().post(url);
    try {
      var result = jsonDecode(response.data);
      if (result != null) {
        for (var map in result) {
          JobBlankModel jobblank = JobBlankModel.fromJson(map);
          setState(() {
            jobBlankModel.add(jobblank);
            loadData = true;
          });
        }
      }else{
        setState(() {
          loadData = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  String timeStemp(String dateDiff){
    double timeStemp = double.parse(dateDiff);
    String _tempStemp = '';
    if(timeStemp < 1.0 ){
      _tempStemp = 'วันนี้';
    }else if(timeStemp > 1.0 && timeStemp < 2.0){
      _tempStemp = 'เมื่อวาน';
    }else{
      _tempStemp = '${timeStemp.toString().split('.')[0]} วันที่แล้ว';
    }
    return _tempStemp;
  }

  Text factoryName(String facetoryName) {
    String name = "";
    if (facetoryName == "sfi") {
      name = "บริษัซีเฟรชอินดัสตรีจำกัด มหาชน";
    } else if (facetoryName == "sff") {
      name = "บริษัทซีเฟรชฟาร์ม จำกัด";
    }

    return Text(name, style: TextStyle(
        fontSize: getProportionateScreenHeight(14),
        fontWeight: FontWeight.bold),);
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

}
