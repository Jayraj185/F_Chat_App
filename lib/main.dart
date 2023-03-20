import 'package:chat/Screens/ChatScreen/View/ChatPage.dart';
import 'package:chat/Screens/HomeScreen/View/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (p0) => HomePage(),
            'Chat': (p0) => ChatPage(),
          },
        );
      },
    ),
  );
}
