import 'package:chat/Screens/ChatScreen/Model/MessageModel.dart';
import 'package:chat/Screens/HomeScreen/Model/ChatUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController
{
  TextEditingController txtChat = TextEditingController();
  RxBool ChatStart = false.obs;
  RxList<MessageModel> MessageList = <MessageModel>[].obs;
  RxList<ChatUser> chatList = <ChatUser>[].obs;
}