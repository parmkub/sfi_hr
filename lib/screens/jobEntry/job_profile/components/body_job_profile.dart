import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../model/job_user_profile_model.dart';
import '../../../../providers/Job_user_profile_provider.dart';

class BodyJobProfile extends StatefulWidget {
  const BodyJobProfile({super.key});

  @override
  State<BodyJobProfile> createState() => _BodyJobProfileState();
}

class _BodyJobProfileState extends State<BodyJobProfile> {
  bool loadData = false;

  XFile? selectImage;

  String? userID;

  String imageUrl = '';

  XFile? image;

  bool loadImageProfile = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return loadData? SingleChildScrollView(
      child: Container(
          width: double.infinity,
          height: SizeConfig.screenHeight,
          child: Consumer(builder: (context,JobUerProfileProvider provider,child){
            return Card(
                elevation: 5,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: kBackgroundColor,
                  )
                  ,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: getProportionateScreenWidth(10),),
                      loadImageProfile ? ImageProfileLoad() :
                      ImageProfileChang(),
                      SizedBox(height: getProportionateScreenWidth(30),),
                      textCard('ชื่อ:', "${provider.jobUserProfile[0].fIRSTNAME ?? " "} ${provider.jobUserProfile[0].lASTNAME??" "}",Icons.person),
                      SizedBox(height: getProportionateScreenWidth(10),),
                      textCard('อีเมล:', provider.jobUserProfile[0].eMAIL ?? " ",Icons.email  ),
                      SizedBox(height: getProportionateScreenWidth(10),),
                      textCard('โทร:', provider.jobUserProfile[0].pHONE ?? " ",Icons.phone ),
                      SizedBox(height: getProportionateScreenWidth(10),),
                      textCard('ที่อยู่:', provider.jobUserProfile[0].aDDRESS ??" ",Icons.location_on),
                      SizedBox(height: getProportionateScreenWidth(10),),

                    ],

                  ),
                )
            );
          })
      ),
    ):Center(child: CircularProgressIndicator(),);
  }
  Future<void> getUserProfile() async {
    loadData = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('userID');
    var provider = Provider.of<JobUerProfileProvider>(context, listen: false);
    print('EditProfile userID: $userID');
    String url = "http://61.7.142.47:8086/sfi-hr/select_job_user_profile.php?user_id=$userID";
    try{
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      if(result != null){
        for(var map in result){
          JobUserProfileModel jobUserProfileModel = JobUserProfileModel.fromJson(map);
          provider.addJobUserProfile(jobUserProfileModel);
          setState(() {
            loadData = true;
          });
        }
      }

    }catch(e){
      print(e);
    }
  }
  Card textCard(String title,String detail,IconData icon){
    return Card(
      color: kSecondaryColor,
      elevation: 2,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(title ,style: TextStyle(fontSize: getProportionateScreenWidth(18),color: Colors.white,fontWeight: FontWeight.bold),),)),
              Expanded(
                  flex: 5,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(detail,style: TextStyle(fontSize: getProportionateScreenWidth(18),color: Colors.white,fontWeight: FontWeight.bold),),
                    )
                  )),
              Expanded(
                  flex: 1,
                  child: Align(
                alignment: Alignment.centerRight,
                child: Icon(icon,color: Colors.white,size: 30,),))
            ],
          ),
        )
    );
  }
  Widget ImageProfileLoad(){
    return Stack(
      children: [
        Positioned(child:
         Container(
          width: 150,
          height: 150,
          child: ClipOval(
            child: FadeInImage(
              placeholder:
              const AssetImage("assets/images/userProfile.png"),
              image:NetworkImage('http://61.7.142.47:8880/sfiblog/upload/profile/$userID.jpg',scale:2),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset("assets/images/userProfile.png",
                    fit: BoxFit.cover);
              },
              fit: BoxFit.cover,
            ),
          ),
        ),
        ),
        Positioned(
          bottom: -5,
          right: -2,
          child: IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {
              print("camera");
              updateImageProfile(userID!);
            },
            color: kSecondaryColor,
            iconSize: 30,
          ),
        )
      ],
    );
  }

  Widget ImageProfileChang(){
    return Stack(
      children: [
        Positioned(child: Container(
          width: 150,
          height: 155,
          child: selectImage != null ? Container(
            child: ClipOval(
              child: Image.file(File(selectImage!.path)
                ,fit: BoxFit.cover,)
            ),
          ) : Image.asset(
            "assets/images/userProfile.png",
            width: 150,
            height: 155,
            fit: BoxFit.cover,
          ),
        ),
        ),
        Positioned(
          bottom: -5,
          right: -2,
          child: IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {
              print("camera");
              updateImageProfile(userID!);
              //setProfileImage();
            },
            color: kSecondaryColor,
            iconSize: 30,
          ),
        )
      ],
    );
  }


  Future<void> updateImageProfile(String fileName) async {

    selectImage = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 800, maxHeight: 800);
    if (selectImage != null) {

      //print("selectImage: ${selectImage!.path}");
      File file = File(selectImage!.path);
      print('fileName: $fileName');
      Map<String, dynamic> map = Map();
      map['file'] = await MultipartFile.fromFile(
        file.path,
        filename: "$fileName.jpg",);
      FormData formData = FormData.fromMap(map);
      String url = "http://61.7.142.47:8880/sfiblog/uploadProfile.php";
      try {
        Response response = await Dio().post(url, data: formData);
        //  print('response: $response');
        if (response.statusCode == 200) {
          print('response: $response');
          //getUserProfile();
          setState(() {
            loadImageProfile = false;
            selectImage = selectImage;
          });
        }else{
          print('response: $response');
        }
      } catch (e) {
        print(e);
      }
    }
  }

}
