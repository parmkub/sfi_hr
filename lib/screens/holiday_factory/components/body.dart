import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/model/calendar_hr_model.dart';
import 'package:sfiasset/model/holiday_show_model.dart';
import 'package:sfiasset/screens/home/components/mark_color_calendar.dart';
import 'package:sfiasset/size_config.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<CarlendarHrModel> calendarAll = [];
  List<Holiday> calendarToDay = <Holiday>[];
  final DateTime today = DateTime.now();

  var result;

  bool statusLoad = false;

  @override
  void initState() {
    //_getDataSource();
    _getDataSourceNew();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return statusLoad ? Card(
      elevation: 20,
      margin: const EdgeInsets.all(10),
      child: Column(children: [

        SizedBox(
          height: getProportionateScreenHeight(650),
          child: SfCalendar(
            view: CalendarView.month,
            // bool showNavigationArrow = false,   bool showDatePickerButton = false,
            showNavigationArrow: true,
            showDatePickerButton: true,
            dataSource: HolidayDataSource(calendarToDay),
            monthViewSettings: MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                showAgenda: true,
                agendaStyle: AgendaStyle(
                  backgroundColor: Colors.white,
                  dateTextStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: getProportionateScreenWidth(12.0)),
                  appointmentTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(12.0)),
                  dayTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(14.0)),
                ),
                monthCellStyle: MonthCellStyle(
                  backgroundColor: Colors.white,
                  trailingDatesBackgroundColor: Colors.white10,
                  leadingDatesBackgroundColor: Colors.white10,
                  todayBackgroundColor: Colors.blue,
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(12.0)),
                ),
                numberOfWeeksInView: 6,
                ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:  [
            MarkColorCalendar(color: 0xFF40E0D0, nameColor: AppLocalizations.of(context).translate('holiday')),
            MarkColorCalendar(color: 0xFFFFFF66, nameColor: AppLocalizations.of(context).translate('activity')),
          ],
        )
      ]),
    ): const Center(child: CircularProgressIndicator());
  }

  Future<void> _getDataSourceNew() async {
    int numRow = 0;
    statusLoad = false;
    String url =
        'http://61.7.142.47:8086/sfi-hr/select_hr_calendar.php?location=chp';
   await Dio().get(url).then((value) => {
     if(value.statusCode == 200){
       setState(() {
         result = jsonDecode(value.data);
         for (var map in result) {
             CarlendarHrModel carlendarHrModel = CarlendarHrModel.fromJson(map);
             calendarAll.add(carlendarHrModel);
           numRow++;
           if (numRow == result.length) {
             for (int i = 0; i < result.length; i++) {
               String year = today.toString().split("-")[0];
               int dateFrom =
               int.parse(calendarAll[i].sTARTDAY!.split("-")[0]);
               int dateTo = int.parse(calendarAll[i].eNDDAY!.split("-")[0]);
               int color = int.parse(calendarAll[i].cOLORTYPE!);

               String month = calendarAll[i].sTARTDAY!.split("-")[1];
               String detail = calendarAll[i].dETAIL!;

               calendarToDay.add(Holiday(
                   DateTime(int.parse(year), int.parse(month), dateFrom),
                   DateTime(int.parse(year), int.parse(month), dateTo),
                   detail,
                   Color(color),
                   false));
             }
           }
         }
         statusLoad = true;
       })
     }else{
       statusLoad = false
     }
   });

  }


  Future<void> _getDataSource() async {
    String url =
        'http://61.7.142.47:8086/sfi-hr/select_hr_calendar.php?location=chp';
    int numRow = 0;
    Response response = await Dio().get(url);
    try {
      var result = jsonDecode(response.data);
      for (var map in result) {
        setState(() {
          CarlendarHrModel carlendarHrModel = CarlendarHrModel.fromJson(map);
          calendarAll.add(carlendarHrModel);
        });
        numRow++;
        if (numRow == result.length) {
          for (int i = 0; i < result.length; i++) {
            String year = today.toString().split("-")[0];
            int dateFrom =
                int.parse(calendarAll[i].sTARTDAY!.split("-")[0]);
            int dateTo = int.parse(calendarAll[i].eNDDAY!.split("-")[0]);
            int color = int.parse(calendarAll[i].cOLORTYPE!);

            String month = calendarAll[i].sTARTDAY!.split("-")[1];
            String detail = calendarAll[i].dETAIL!;

            calendarToDay.add(Holiday(
                DateTime(int.parse(year), int.parse(month), dateFrom),
                DateTime(int.parse(year), int.parse(month), dateTo),
                detail,
                Color(color),
                false));
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
