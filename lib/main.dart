import 'package:chat/Screens/ChatScreen/View/ChatPage.dart';
import 'package:chat/Screens/HomeScreen/View/HomePage.dart';
import 'package:chat/Screens/SignInScreen/View/SignInPage.dart';
import 'package:chat/Screens/SignUpScreen/View/SignUpPage.dart';
import 'package:chat/Screens/SplashScreen/View/SplashPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp();

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (p0) => SplashPage(),
            'SignIn': (p0) => SignInPage(),
            'SignUp': (p0) => SignUpPage(),
            'Home': (p0) => HomePage(),
            'Chat': (p0) => ChatPage(),
          },
        );
      },
    ),
  );
}
