import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      initialRoute: SplashScreen.routName,
      routes: routs,
    );
  }
}
