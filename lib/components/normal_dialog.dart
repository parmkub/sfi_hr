import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/components/sigout_process.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/size_config.dart';

Future<void> normalDialog(BuildContext context, String message,IconData icon,Color color) async {
  showDialog(context: context, builder: (context)=>SimpleDialog(
    title: Text(message),
    children: <Widget>[
       Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: getProportionateScreenWidth(50),
            color: color
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:  Text(
              AppLocalizations.of(context).translate('ok'),
              style: TextStyle(fontSize: getProportionateScreenWidth(16),color: Colors.green),
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding:const EdgeInsets.all(2),
                    child:
                    TextButton(
                      style: TextButton.styleFrom(
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
                        style: TextStyle(fontSize: getProportionateScreenWidth(16.0),color: Colors.green),
                      ),
                    ),
                  ),),
                SizedBox(width: getProportionateScreenWidth(10.0),),
                // ignore: deprecated_member_use

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(2),
                    child:
                    TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: ()=> Navigator.pop(context),
                      child:  Text(
                        AppLocalizations.of(context).translate('no'),
                        style: TextStyle(fontSize: getProportionateScreenWidth(16.0),color: Colors.red )
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

