import 'package:chat/Screens/ChatScreen/Model/MessageModel.dart';
import 'package:chat/Utils/TimeFormate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MessageWidget
{
  MessageWidget._();

  static MessageWidget messageWidget = MessageWidget._();

  Widget MeSendMessage({required MessageModel message,required BuildContext context})
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEFD3BF),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(1000),topRight: Radius.circular(1000),bottomLeft: Radius.circular(1000)),
                ),
                padding: EdgeInsets.all(Get.width/30),
                margin: EdgeInsets.only(right: Get.width/60,bottom: Get.width/60,left: Get.width/12),
                child: Text(
                  "${message.message}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp
                  ),
                ),
              ),
              Text(
                "${TimeFormate.timeFormate.FormateTime(context, "${message.sent}")}",
                maxLines: 1,
                style: TextStyle(
                    color: Colors.grey,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 9.sp
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget FromSendMessage({required MessageModel message,required BuildContext context})
  {
    return Row(
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFF1BF),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(1000),topRight: Radius.circular(1000),bottomLeft: Radius.circular(1000)),
                ),
                padding: EdgeInsets.all(Get.width/30),
                margin: EdgeInsets.only(left: Get.width/60,bottom: Get.width/60,right: Get.width/12),
                child: Text(
                  "${message.message}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp
                  ),
                ),
              ),
              Text(
                  "${TimeFormate.timeFormate.FormateTime(context, "${message.sent}")}",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 9.sp
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}