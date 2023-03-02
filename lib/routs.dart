

import 'package:flutter/cupertino.dart';
import 'package:sfiasset/model/team_model.dart';
import 'package:sfiasset/screens/approve_holiday/approve_holiday_screen.dart';
import 'package:sfiasset/screens/emp_card/emp_card_screen.dart';
import 'package:sfiasset/screens/holiday/components/report_leaving_pdf.dart';
import 'package:sfiasset/screens/holiday/form_leaving_screen.dart';
import 'package:sfiasset/screens/holiday/holiday_screen.dart';
import 'package:sfiasset/screens/holiday_factory/holiday_factory_screen.dart';
import 'package:sfiasset/screens/home/home_screen.dart';
import 'package:sfiasset/screens/home/publicize_screen/publicize_screen.dart';
import 'package:sfiasset/screens/hr_team/hr_team_screen.dart';
import 'package:sfiasset/screens/jobEntry/job_entry_screen.dart';
import 'package:sfiasset/screens/sign_in/sign_in_screen.dart';
import 'package:sfiasset/screens/splash_screen/splash_screen.dart';
import 'package:sfiasset/screens/team/team_screen.dart';
import 'package:sfiasset/screens/team_statics/team_statics_screen.dart';
import 'package:sfiasset/screens/user_manual/user_manual_screen.dart';

import 'screens/publicize_all/publicize_all_screen.dart';


final Map<String, WidgetBuilder> routs = {

  SplashScreen.routName : (context)=>const SplashScreen(),
  SignInScreen.routName : (context)=>const SignInScreen(),
  HomeScreen.routName : (context)=>const HomeScreen(),
  HolidayScreen.routName : (context)=> const HolidayScreen(),
  JobEntryScreen.routName : (context)=> const JobEntryScreen(),
  FormLeavingScreen.routName : (context)=> const FormLeavingScreen(),
  LeavingDocument.routName : (context)=> const LeavingDocument(),
  EmpCardScreen.routName : (context)=> const EmpCardScreen(),
  TeamScreen.routName: (context)=> const TeamScreen(),
  HolidayFactoryScreen.routName : (context)=> const HolidayFactoryScreen(),
  ApproveHolidayScreen.routName : (context)=> const ApproveHolidayScreen(),
  UserManualScreen.routName : (context)=> const UserManualScreen(),
  PublicezeScreen.routName : (context)=> const PublicezeScreen(),
  PublicizeAllScreen.routName : (context)=> const PublicizeAllScreen(),
  HRTeamScreen.routName : (context)=> const HRTeamScreen(),
  TeamStatics.routName : (context)=>   TeamStatics(teamModel: ModalRoute.of(context)!.settings.arguments as TeamModel),
  // FixScreen.routName : (context)=>FixScreen(),
};