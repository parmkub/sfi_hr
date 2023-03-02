import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/model/publicize_model.dart';
import 'package:sfiasset/screens/home/publicize_screen/publicize_screen.dart';
import 'package:sfiasset/size_config.dart';

class BodyUserManual extends StatefulWidget {
  final String blogType;
  const BodyUserManual({Key? key, required this.blogType}) : super(key: key);

  @override
  State<BodyUserManual> createState() => _BodyUserManualState();
}

class _BodyUserManualState extends State<BodyUserManual> {
  List<PublicizeModel> publicizeAll = [];

  bool statusLoad = false;

  bool statusConect = false;

  @override
  void initState() {
    _getPublicize();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(gradient: kBackgroundColor),
        child: statusLoad
            ? RefreshIndicator(
                onRefresh: _getPublicize,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(gradient: kBackgroundColor),
                  child: ListView.builder(
                    itemCount: publicizeAll.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, PublicezeScreen.routName,
                              arguments: {
                                'id': publicizeAll[index].iD,
                                'webViewType': publicizeAll[index].wEBVIEWTYPE,
                                'publicizeDetail': publicizeAll[index].dETAIL
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Card(
                              margin: const EdgeInsets.all(5),
                              elevation: 5,
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                height: getProportionateScreenHeight(180),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '${publicizeAll[index].tHUMNAIL}'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )),
                        ),
                      );
                    },
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              )
    );
  }

  Future<void> _getPublicize() async {
    String url =
        'http://61.7.142.47:8086/sfi-hr/select_hr_publicize_all.php?blogType=${widget.blogType}';
    await Dio().get(url).then((value) {
      debugPrint('สถานนะโค้ด ${value.statusCode}');
      try {
        if (value.statusCode == 200) {
          var result = jsonDecode(value.data);
          if (result != null) {
            setState(() {
              publicizeAll.clear();
              for (var map in result) {
                publicizeAll.add(PublicizeModel.fromJson(map));
              }
              statusLoad = true;
            });
          } else {
            setState(() {
              statusLoad = false;
            });

          }
          //print('result $result');
        }else{
          Future.delayed(const Duration(seconds: 3), () {
            setState(() {
              statusLoad = true;
            });
          });
        }
      } catch (e) {
        debugPrint('error $e');
      }
    });
  }
}
