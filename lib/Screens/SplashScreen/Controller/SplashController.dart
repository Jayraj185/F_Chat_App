import 'dart:async';

import 'package:chat/Utils/FireabseHelper/FireabseHelper.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
{

  //Check User Login Or Not
  Future<void>
  IsLogin()
  async {
    bool Login = await FirebaseHelper.firebaseHelper.CheckSignIn();
    if(Login)
      {
        Timer(Duration(seconds: 3), () {
          Get.offNamed('Home');
        });
      }
    else
      {
        Timer(Duration(seconds: 3), () {
          Get.offNamed('SignIn');
        });
      }
  }
}