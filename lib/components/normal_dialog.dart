import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/components/sigout_process.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/size_config.dart';

Future<void> normalDialog(BuildContext context, String message) async {
  showDialog(context: context, builder: (context)=>SimpleDialog(
    title: Text(message),
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
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
          // ignore: deprecated_member_use
        /*  FlatButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(fontSize: 18),
            ),
          )*/
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(fontSize: 18),
            ),
          )

        ],
      )

    ],
  ));
}


Future<void> normalDialogYesNo(BuildContext context, String message ) async {
  showDialog(context: context, builder: (context)=>SimpleDialog(
    title: Text(message,style: const TextStyle(color: kTextColor),),
    children: <Widget>[
      Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child:Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                    Icons.question_answer_outlined,
                    size: 50,
                    color: kPrimaryColor
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(10.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding:const EdgeInsets.all(2),
                    child: /*FlatButton(
                      color: Colors.red,
                      onPressed: (){
                        SignOutProcess(context);
                      }
                      ,
                      child:  Text(
                        'ใช่',
                        style: TextStyle(fontSize: getProportionateScreenWidth(16.0),color: Colors.white),
                      ),
                    ),*/
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: (){
                        SignOutProcess(context);
                      }
                      ,
                      child:  Text(
                        AppLocalizations.of(context).translate('yes'),
                        style: TextStyle(fontSize: getProportionateScreenWidth(16.0),color: Colors.white),
                      ),
                    ),
                  ),),
                // ignore: deprecated_member_use

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    child: /*FlatButton(
                      color: Colors.green,
                      onPressed: ()=> Navigator.pop(context),
                      child:  Text(
                        'ไม่ใช่',
                        style: TextStyle(fontSize: getProportionateScreenWidth(16.0),color: Colors.white),
                      ),
                    ),*/
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: ()=> Navigator.pop(context),
                      child:  Text(
                        AppLocalizations.of(context).translate('no'),
                        style: TextStyle(fontSize: getProportionateScreenWidth(16.0),color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )



    ],
  ));
}

