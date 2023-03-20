import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController
{
  TextEditingController txtSignInPass = TextEditingController();
  TextEditingController txtSignInEmail = TextEditingController();
  RxBool SignIn_password_vis = true.obs;
  GlobalKey<FormState> SignInkey = GlobalKey<FormState>();
}