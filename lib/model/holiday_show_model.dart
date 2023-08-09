
import 'dart:ui';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class HolidayDataSource extends CalendarDataSource {
  HolidayDataSource(List<Holiday> source){
    appointments = source;

  }
  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }
  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }
  @override
  String getSubject(int index){

    return appointments![index].holidayName;
  }
  @override
  Color getColor(int index){
    return appointments![index].background;
  }
  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

}

class Holiday {
  Holiday(this.from,this.to,this.holidayName,this.background,this.isAllDay);
  DateTime from;
  DateTime to;
  String holidayName;
  Color background;
  bool isAllDay;
}