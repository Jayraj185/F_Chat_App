import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController
{
  TextEditingController txtChat = TextEditingController();
  RxBool ChatStart = false.obs;
}