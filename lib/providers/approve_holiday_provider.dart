

import 'package:flutter/cupertino.dart';

import '../model/approve_holiday_model.dart';

class ApproveHolidayProvider with ChangeNotifier{
  List<ApproveHoliday> ApproveHolidayCard = [];


  List<ApproveHoliday> getleavingCards(){
    return ApproveHolidayCard;
  }

  addLeavingCard(ApproveHoliday statement){
    ApproveHolidayCard.insert(0, statement);
    notifyListeners();
  }

  removeLeavingCard(){
    ApproveHolidayCard.clear();
  }

}