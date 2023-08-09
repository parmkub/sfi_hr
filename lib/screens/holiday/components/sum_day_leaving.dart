import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';

class SumLeavingDay extends StatelessWidget {
  final String day,hour;
  const SumLeavingDay({
    Key? key, required this.day, required this.hour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? _dayHour;
    if(hour =="0"){
      _dayHour = "$day ${AppLocalizations.of(context).translate('day')}";
    }else{
      _dayHour ="$hour ${AppLocalizations.of(context).translate('hour')} ";
    }

    return Text(
      '${AppLocalizations.of(context).translate('sumDay')}       : $_dayHour ',
      style: const TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold),
    );
  }
}