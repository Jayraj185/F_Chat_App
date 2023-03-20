import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController
{
  TextEditingController txtSignUpPass = TextEditingController();
  TextEditingController txtSignUpEmail = TextEditingController();
  RxBool SignUp_password_vis = true.obs;
  GlobalKey<FormState> SignUpkey = GlobalKey<FormState>();
}