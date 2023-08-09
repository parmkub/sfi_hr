


import 'package:flutter/cupertino.dart';
import 'package:sfiasset/model/chang_holiday_model.dart';

class ApproveChangHolidayProvider extends ChangeNotifier {
  List<ChangHolidayModel> changHoliday = [];

  List<ChangHolidayModel>  ChangHoliday(){
    return changHoliday;
  }

  void addChangHolidayCard(ChangHolidayModel approveHoliday) {
    changHoliday.insert(0, approveHoliday);
    notifyListeners();
  }

  void removeChangHolidayCard() {
    changHoliday.clear();
  }
}