import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeFormate
{
  TimeFormate._();

  static TimeFormate timeFormate = TimeFormate._();


  //Get Message Time Formats
  String FormateTime(BuildContext context,String time)
  {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    
    return TimeOfDay.fromDateTime(dateTime).format(context);
  }

  //Get Last Message Time
  String LastMessageTime({required BuildContext context, required String time})
  {
    DateTime sentTime = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    DateTime nowTime = DateTime.now();

    if((nowTime.day == sentTime.day) && (nowTime.month == sentTime.month) && (nowTime.year == sentTime.year))
      {
        return TimeOfDay.fromDateTime(sentTime).format(context);
      }
    else
      {
        return "${sentTime.day} ${GetMonth(month: sentTime.month.toString())}";
      }
  }

  // Get Last Active Time
  String LastActiveTime({required BuildContext context, required String time})
  {
    DateTime sentTime = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    DateTime nowTime = DateTime.now();
    if((nowTime.day == sentTime.day) && (nowTime.month == sentTime.month) && (nowTime.year == sentTime.year))
      {
        return "Last seen today at ${FormateTime(context, time)}";
      }
    else if((nowTime.difference(sentTime).inHours / 24).round() == 1)
      {
        return "Last seen yesterday at ${FormateTime(context, time)}";
      }
    else
      {
        return "Last seen on ${sentTime.day} ${GetMonth(month: sentTime.month.toString())} on ${FormateTime(context, time)}";
      }
  }



  //Get Month
  String GetMonth({required String month})
  {
    if(month == 1)
    {
      month = "Jan";
    }
    else if(month == 2)
    {
      month = "Feb";
    }
    else if(month == 3)
    {
      month = "Mar";
    }
    else if(month == 4)
    {
      month = "Apr";
    }
    else if(month == 5)
    {
      month = "May";
    }
    else if(month == 6)
    {
      month = "Jun";
    }else if(month == 7)
    {
      month = "Jul";
    }
    else if(month == 8)
    {
      month = "Aug";
    }
    else if(month == 9)
    {
      month = "Sept";
    }
    else if(month == 10)
    {
      month = "Oct";
    }
    else if(month == 11)
    {
      month = "Nov";
    }
    else if(month == 12)
    {
      month = "Dec";
    }
    return month;
  }
}