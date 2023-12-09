import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/firebase_options.dart';
import 'package:sfiasset/providers/Job_user_profile_provider.dart';
import 'package:sfiasset/providers/approve_chang_holiday_provider.dart';
import 'package:sfiasset/providers/approve_holiday_provider.dart';
import 'package:sfiasset/providers/leaving_provider.dart';
import 'package:sfiasset/routs.dart';
import 'package:sfiasset/screens/splash_screen/splash_screen.dart';
import 'package:sfiasset/theme.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) {
      return LeavingProvider();
    }),
    ChangeNotifierProvider(create: (context) {
      return ApproveHolidayProvider();
    }),
    ChangeNotifierProvider(create: (context){
      return ApproveChangHolidayProvider();
    }),
    ChangeNotifierProvider(create: (context){
      return JobUerProfileProvider();
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
