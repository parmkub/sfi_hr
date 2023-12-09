

import 'package:flutter/cupertino.dart';
import 'package:sfiasset/model/job_blank_model.dart';
import 'package:sfiasset/model/team_model.dart';
import 'package:sfiasset/screens/appeal_screen/appeal_screen.dart';
import 'package:sfiasset/screens/approve_holiday/approve_holiday_screen.dart';
import 'package:sfiasset/screens/connect_loss/connect_loss_screen.dart';
import 'package:sfiasset/screens/emp_card/emp_card_screen.dart';
import 'package:sfiasset/screens/holiday/form_leaving_screen.dart';
import 'package:sfiasset/screens/holiday/holiday_screen.dart';
import 'package:sfiasset/screens/holiday_factory/holiday_factory_screen.dart';
import 'package:sfiasset/screens/home/home_screen.dart';
import 'package:sfiasset/screens/home/publicize_screen/publicize_screen.dart';
import 'package:sfiasset/screens/hr_team/hr_team_screen.dart';
import 'package:sfiasset/screens/jobEntry/job_detail_screen/job_detail_screen.dart';
import 'package:sfiasset/screens/jobEntry/job_entry_screen.dart';
import 'package:sfiasset/screens/jobEntry/job_my_work/job_my_screen.dart';
import 'package:sfiasset/screens/jobEntry/job_profile/job_edit_profile.dart';
import 'package:sfiasset/screens/jobEntry/job_profile/job_profile.dart';
import 'package:sfiasset/screens/jobEntry/job_registor/job_registor.dart';
import 'package:sfiasset/screens/jobEntry/job_reset_password/job_reset_password.dart';
import 'package:sfiasset/screens/jobEntry/job_screen.dart';
import 'package:sfiasset/screens/jobEntry/job_setting/job_setting.dart';
import 'package:sfiasset/screens/jobEntry/job_sign_in/job_sign_in_screen.dart';
import 'package:sfiasset/screens/menu_main_screen/menu_main.dart';
import 'package:sfiasset/screens/policy/policy_screen.dart';
import 'package:sfiasset/screens/publicize_all/publicize_all_screen.dart';
import 'package:sfiasset/screens/registor_screen/check_user_screen.dart';
import 'package:sfiasset/screens/registor_screen/registor_screen.dart';
import 'package:sfiasset/screens/sign_in/sign_in_screen.dart';
import 'package:sfiasset/screens/splash_screen/splash_screen.dart';
import 'package:sfiasset/screens/team/team_screen.dart';
import 'package:sfiasset/screens/team_statics/team_statics_screen.dart';
import 'package:sfiasset/screens/user_manual/user_manual_screen.dart';



final Map<String, WidgetBuilder> routs = {

  SplashScreen.routName : (context)=>const SplashScreen(),
  SignInScreen.routName : (context)=>const SignInScreen(),
  HomeScreen.routName : (context)=>const HomeScreen(),
  HolidayScreen.routName : (context)=>  HolidayScreen(indexPage: 0,),
  JobEntryScreen.routName : (context)=> const JobEntryScreen(),
  FormLeavingScreen.routName : (context)=> const FormLeavingScreen(),
  EmpCardScreen.routName : (context)=> const EmpCardScreen(),
  TeamScreen.routName: (context)=> const TeamScreen(),
  HolidayFactoryScreen.routName : (context)=> const HolidayFactoryScreen(),
  ApproveHolidayScreen.routName : (context)=> const ApproveHolidayScreen(),
  UserManualScreen.routName : (context)=> const UserManualScreen(),
  PublicezeScreen.routName : (context)=> const PublicezeScreen(),
  PublicizeAllScreen.routName : (context)=> const PublicizeAllScreen(),
  HRTeamScreen.routName : (context)=> const HRTeamScreen(),
  TeamStatics.routName : (context)=>   TeamStatics(teamModel: ModalRoute.of(context)!.settings.arguments as TeamModel),
  AppealScreen.routName : (context)=> const AppealScreen(),
  ConnectLossScreen.routName : (context)=> const ConnectLossScreen(),
  RegistorScreen.routName : (context)=>   const RegistorScreen(username: '',empCode: '',name: '',),
  CheckUserSceen.routName : (context)=> const CheckUserSceen(),
  PolicyScreen.routName : (context)=> const PolicyScreen(),
  JobScreen.routName : (context)=> const JobScreen(),
  JobDetailScreen.routName : (context)=>  JobDetailScreen(jobBlankModel: ModalRoute.of(context)!.settings.arguments as JobBlankModel,showButtonSubmit: true,),
  JobSignInScreen.routName : (context)=> const JobSignInScreen(),
  JobRegistor.routName : (context)=> const JobRegistor(),
  JobMyScreen.routName : (context)=> const JobMyScreen(),
  JobProfile.routName : (context)=> const JobProfile(),
  JobEditProfile.routName : (context)=> const JobEditProfile(),
  JobSettings.routName : (context)=> const JobSettings(),
  JobResetPassword.routName : (context)=> const JobResetPassword(),
  MenuMainScreen.routName : (context)=> const MenuMainScreen(),
  // FixScreen.routName : (context)=>FixScreen(),
};