import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeFormate
{
  TimeFormate._();

  static TimeFormate timeFormate = TimeFormate._();


  String FormateTime(BuildContext context,String time)
  {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    
    return TimeOfDay.fromDateTime(dateTime).format(context);
  }
}