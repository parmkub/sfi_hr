import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/screens/sign_in/components/sign_form.dart';
import 'package:sfiasset/size_config.dart';


class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),//คลิ๊กตรงไหนก็ได้เพื่อเก็บ keybord
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[

                  Text(
                    AppLocalizations.of(context).translate('wellcome'),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(20),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    AppLocalizations.of(context).translate('typeTitleLogin'),
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: getProportionateScreenWidth(12.0)),
                  ),
                  Image.asset(
                    "assets/images/Login.png",
                    height: getProportionateScreenHeight(265),
                    width: getProportionateScreenWidth(235),
                  ),
                    const SignForm(),
                  SizedBox(
                    height: SizeConfig.screenHeight! * 0.08,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
