import 'package:chat/Screens/HomeScreen/Model/ChatUser.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
{
  RxList<ChatUser> UserList = <ChatUser>[].obs;

  ChatUser chatUser = ChatUser();
}