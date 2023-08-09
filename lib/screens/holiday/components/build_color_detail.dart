import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/screens/home/components/mark_color_calendar.dart';

class BuildColorDetail extends StatelessWidget {
  const BuildColorDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MarkColorCalendar(
                    color: 0xFF0F8644,
                    nameColor:
                    AppLocalizations.of(context).translate('holiday')),
                MarkColorCalendar(
                    color: 0xFFFFFF66,
                    nameColor:
                    AppLocalizations.of(context).translate('dayChange')),
                MarkColorCalendar(
                    color: 0xFF094999,
                    nameColor:
                    AppLocalizations.of(context).translate('lapukron'))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MarkColorCalendar(
                    color: 0xFFFF9933,
                    nameColor: AppLocalizations.of(context).translate('lagit')),
                MarkColorCalendar(
                    color: 0xFF66CCFF,
                    nameColor: AppLocalizations.of(context).translate('sick')),
                MarkColorCalendar(
                    color: 0xFF9933CC,
                    nameColor: AppLocalizations.of(context).translate('lakron'))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MarkColorCalendar(
                    color: 0xFFCC0066,
                    nameColor:
                    AppLocalizations.of(context).translate('accident')),
                MarkColorCalendar(
                    color: 0xFFFF0000,
                    nameColor: AppLocalizations.of(context)
                        .translate('absentFromWork')),
                MarkColorCalendar(
                    color: 0xFFCD853F,
                    nameColor: AppLocalizations.of(context).translate('ordain'))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MarkColorCalendar(
                    color: 0xFF40E0D0,
                    nameColor: AppLocalizations.of(context)
                        .translate('factoryHoliday')),
              ],
            ),

            //DefaultButton(text: "บันทึกวันหยุดประจำเดือน", press: () {})
          ],
        ),
      ),
    );
  }
}