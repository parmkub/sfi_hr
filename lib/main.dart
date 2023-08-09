import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/providers/approve_chang_holiday_provider.dart';
import 'package:sfiasset/providers/approve_holiday_provider.dart';
import 'package:sfiasset/providers/leaving_provider.dart';
import 'package:sfiasset/routs.dart';
import 'package:sfiasset/screens/splash_screen/splash_screen.dart';
import 'package:sfiasset/theme.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) {
      return LeavingProvider();
    }),
    ChangeNotifierProvider(create: (context) {
      return ApproveHolidayProvider();
    }),
    ChangeNotifierProvider(create: (context){
      return ApproveChangHolidayProvider();
    })
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HR 4.0',
      theme: theme(),
      supportedLocales: const <Locale>[
        Locale('en', 'US'),//English
        Locale('th', 'TH'),//Thai
        Locale('mm','MM'),
        Locale('jp','JP')//Japan
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (final supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      initialRoute: SplashScreen.routName,
      routes: routs,
    );
  }
}
