

import 'package:flutter/cupertino.dart';

import '../model/job_user_profile_model.dart';

class JobUerProfileProvider with ChangeNotifier{
  List<JobUserProfileModel> jobUserProfile = [];

  List<JobUserProfileModel> JobUserProfile(){
    return jobUserProfile;
  }

  void addJobUserProfile(JobUserProfileModel jobUserProfileModel){
    jobUserProfile.insert(0, jobUserProfileModel);
    notifyListeners();
  }

  void removeJobUserProfile(){
    jobUserProfile.clear();
  }
}