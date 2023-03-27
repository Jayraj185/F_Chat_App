import 'package:chat/Screens/ChatScreen/Controller/ChatController.dart';
import 'package:chat/Screens/ChatScreen/Model/MessageModel.dart';
import 'package:chat/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:chat/Screens/HomeScreen/Model/ChatUser.dart';
import 'package:chat/Utils/ApiHttp/PostNotification.dart';
import 'package:chat/Utils/FireabseHelper/FireabseHelper.dart';
import 'package:chat/Utils/MessageWidget.dart';
import 'package:chat/Utils/TimeFormate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  ChatController chatController = Get.put(ChatController());
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF703efe),
      body: Column(
        children: [
          Container(
            // height: Get.height,
            width: Get.width,
            color: const Color(0xFF703efe),
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(right: Get.width/80,left: Get.width/80,top: Get.width/9),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseHelper.firebaseHelper.GetUserInfo(chatUser: homeController.chatUser),
              builder: (context, snapshot) {
                if(snapshot.hasData)
                  {
                    var docs = snapshot.data!.docs;
                    chatController.chatList.value = [];
                    for(var doc in docs)
                    {
                      Map map = doc.data() as Map;
                      ChatUser chatUser = ChatUser.fromJson(map);
                      chatController.chatList.add(chatUser);
                    }
                    return Row(
                      children: [
                        IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios_new),color: Colors.white,),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage("${chatController.chatList.isNotEmpty ? chatController.chatList[0].image : homeController.chatUser.image}"),
                          radius: Get.width/17,
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text("${chatController.chatList.isNotEmpty ? chatController.chatList[0].name : homeController.chatUser.name}", maxLines: 1,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                            subtitle: Text("${chatController.chatList.isNotEmpty ? chatController.chatList[0].isOnline == true ? "Online" : TimeFormate.timeFormate.LastActiveTime(context: context, time: chatController.chatList[0].lastActive!) : TimeFormate.timeFormate.LastActiveTime(context: context, time: homeController.chatUser.lastActive!)}", maxLines: 1,style: TextStyle(color: chatController.chatList.isNotEmpty ? chatController.chatList[0].isOnline == true ? Colors.green : Colors.grey : Colors.grey,overflow: TextOverflow.ellipsis),),
                          ),
                        ),
                        Icon(Icons.videocam_outlined,color: Colors.white,size: 25.sp,),
                        SizedBox(width: Get.width/45,),
                        Icon(Icons.call_outlined,color: Colors.white,size: 21.sp,),
                        SizedBox(width: Get.width/30,),
                        // IconButton(onPressed: (){}, icon: Icon(Icons.videocam_outlined,color: Colors.white,size: 25.sp,)),
                        // IconButton(onPressed: (){}, icon: Icon(Icons.call_outlined,color: Colors.white,size: 21.sp,)),
                      ],
                    );
                  }
                return const Center(child: CircularProgressIndicator(color: Color(0xFF703efe),),);
              },
            )
          ),
          Expanded(
            child: Container(
              height: Get.height/1.18,
              width: Get.width,
              decoration: const BoxDecoration(
                  color: Color(0xFFECF4FF),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(45),topRight: Radius.circular(45))
              ),
              child: Column(
                children: [
                  Expanded(
                    // child: SingleChildScrollView(
                    //   reverse: true,
                    //   physics: BouncingScrollPhysics(),
                    //   child: Padding(
                    //     padding: EdgeInsets.only(left: Get.width/30, right: Get.width/30, top: Get.width/15),
                    //     child: Column(
                    //       children: [
                    //         MessageWidget.messageWidget.FromSendMessage(msg: "How Are You ?"),
                    //         SizedBox(height: Get.width/30,),
                    //         MessageWidget.messageWidget.FromSendMessage(msg: "How Are You ?"),
                    //         SizedBox(height: Get.width/30,),
                    //         MessageWidget.messageWidget.MeSendMessage(msg: "I'm Fine"),
                    //         SizedBox(height: Get.width/60,),
                    //         MessageWidget.messageWidget.MeSendMessage(msg: "I'm Fine"),
                    //         SizedBox(height: Get.width/30,),
                    //         MessageWidget.messageWidget.MeSendMessage(msg: "I'm Fine"),
                    //         SizedBox(height: Get.width/30,),
                    //         MessageWidget.messageWidget.MeSendMessage(msg: "I'm Fine"),
                    //         SizedBox(height: Get.width/30,),
                    //         MessageWidget.messageWidget.MeSendMessage(msg: "I'm Fine"),
                    //         SizedBox(height: Get.width/30,),
                    //         MessageWidget.messageWidget.MeSendMessage(msg: "I'm Fine"),
                    //         SizedBox(height: Get.width/30,),
                    //         MessageWidget.messageWidget.MeSendMessage(msg: "I'm Fine"),
                    //         SizedBox(height: Get.width/30,),
                    //         MessageWidget.messageWidget.FromSendMessage(msg: "How Are You ?"),
                    //         SizedBox(height: Get.width/30,),
                    //         MessageWidget.messageWidget.MeSendMessage(msg: "I'm Fine"),
                    //         SizedBox(height: Get.width/60,),
                    //         MessageWidget.messageWidget.MeSendMessage(msg: "I'm Fine"),
                    //         SizedBox(height: Get.width/60,),
                    //         MessageWidget.messageWidget.MeSendMessage(msg: "I'm Fine"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseHelper.firebaseHelper.ReadMessage(userData: homeController.chatUser.toJson()),
                      builder: (context, snapshot) {
                        if(snapshot.hasError)
                          {
                            return Center(child: Text("${snapshot.error}",style: TextStyle(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.bold),));
                          }
                        else if(snapshot.hasData)
                          {
                            var docs = snapshot.data!.docs;
                            chatController.MessageList.value = [];
                            for(var doc in docs)
                            {
                              Map map = doc.data() as Map;
                              MessageModel UserMessage = MessageModel.fromJson(map);
                              chatController.MessageList.add(UserMessage);
                            }
                            if(chatController.MessageList.isNotEmpty)
                              {
                                return Obx(
                                    () => ListView.builder(
                                    itemCount: chatController.MessageList.length,
                                    // addAutomaticKeepAlives: false,
                                    //   addRepaintBoundaries: true,
                                    //   addSemanticIndexes: true,
                                      reverse: true,
                                    itemBuilder: (context, index) {
                                      return FirebaseHelper.user!.uid == chatController.MessageList[index].fromId
                                          ? Padding(
                                            padding: EdgeInsets.only(right: Get.width/50,bottom: Get.width/40),
                                            child: FocusedMenuHolder(
                                              menuItems: [
                                                FocusedMenuItem(
                                                  title: Text("Delete"),
                                                  onPressed: (){
                                                    FirebaseHelper.firebaseHelper.DeleteMessage(id: chatController.MessageList[index].sent!,userData: chatController.chatList.isNotEmpty ? chatController.chatList[0].toJson() : homeController.chatUser.toJson());
                                                  }
                                                )
                                              ],
                                              child: MessageWidget.messageWidget.MeSendMessage(message: chatController.MessageList[index],context: context),
                                              onPressed: (){},
                                            ),
                                          )
                                          : Padding(
                                            padding: EdgeInsets.only(left: Get.width/50,bottom: Get.width/40),
                                            child: FocusedMenuHolder(
                                              menuItems: [
                                                FocusedMenuItem(
                                                    title: Text("Delete"),
                                                    onPressed: (){
                                                      FirebaseHelper.firebaseHelper.DeleteMessage(id: chatController.MessageList[index].sent!,userData: chatController.chatList.isNotEmpty ? chatController.chatList[0].toJson() : homeController.chatUser.toJson());
                                                    }
                                                )
                                              ],
                                              child: MessageWidget.messageWidget.FromSendMessage(message: chatController.MessageList[index],context: context),
                                              onPressed: (){},
                                            ),
                                            // child: MessageWidget.messageWidget.FromSendMessage(message: chatController.MessageList[index],context: context),
                                          );
                                    },
                                  ),
                                );
                              }
                            else
                              {
                                return Center(child: Text("Sey Hii..! 👋👋",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21.sp),),);
                              }
                          }
                        return Center(child: CircularProgressIndicator(color: const Color(0xFF703efe),),);
                      },
                    ),
                  ),
                  Container(
                    height: Get.width/8,
                    // width: Get.width/1.12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    margin: EdgeInsets.only(left: Get.width/30, right: Get.width/30,),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.emoji_emotions_outlined),
                        ),
                        Expanded(
                          child: TextField(
                            controller: chatController.txtChat,
                            onChanged: (value) {
                              if(value.isNotEmpty)
                                {
                                  chatController.ChatStart.value = true;
                                }
                              else
                                {
                                  chatController.ChatStart.value = false;
                                }
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type Message Here...."
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            if(chatController.ChatStart.value)
                              {
                                ChatUser chatUser = homeController.chatUser;
                                Map<String,dynamic> userData = chatUser.toJson();
                                if(chatController.chatList[0].isOnline == true)
                                  {
                                    FirebaseHelper.firebaseHelper.SendMessage(userData: userData, message: chatController.txtChat.text);
                                  }
                                else
                                  {
                                    ApiHttp.apiHttp.PostNotification(title: homeController.chatUser.name!, body: chatController.txtChat.text, token: homeController.chatUser.Token!);
                                    FirebaseHelper.firebaseHelper.SendMessage(userData: userData, message: chatController.txtChat.text);
                                  }
                                chatController.txtChat.text='';
                                chatController.ChatStart.value =false;
                              }
                          },
                          child: Container(
                            height: Get.width/9,
                            width: Get.width/9,
                            margin: EdgeInsets.only(right: Get.width/90),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF703efe)
                            ),
                            alignment: Alignment.center,
                            child: Obx(() => Image.asset("${chatController.ChatStart.value ? "assets/image/send.png" : "assets/image/mic.png"}",height: Get.width/15,width: Get.width/15,color: Colors.white,)),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: Get.width/90,)
                ],
              ),
              // child: ListView.builder(
              //   physics: const BouncingScrollPhysics(),
              //   itemCount: 15,
              //   itemBuilder: (context, index) {
              //     return InkWell(
              //       onTap: (){
              //         Get.toNamed('Chat');
              //       },
              //       child: Container(
              //         height: Get.height/9,
              //         width: Get.width,
              //         // color: Colors.red,
              //         // alignment: Alignment.centerLeft,
              //         child: Card(
              //           color: const Color(0xFFECF4FF),
              //           elevation: 0,
              //           child: Row(
              //             children: [
              //               CircleAvatar(
              //                 radius: Get.height/23,
              //                 backgroundImage: NetworkImage("https://funkylife.in/wp-content/uploads/2023/01/whatsapp-dp-by-funkylife-561-1.jpg"),
              //                 backgroundColor: const Color(0xFF703efe),
              //               ),
              //               Container(
              //                 width: Get.width/1.7,
              //                 color: const Color(0xFFECF4FF),
              //                 // color: Colors.purpleAccent,
              //                 padding: EdgeInsets.only(left: Get.width/30),
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Text(
              //                       "Dharmik Bhaliya",
              //                       maxLines: 1,
              //                       style: TextStyle(
              //                           color: Colors.black,
              //                           fontSize: 14.sp,
              //                           overflow: TextOverflow.ellipsis,
              //                           fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                     SizedBox(height: Get.width/90,),
              //                     Text(
              //                       "How Are you ?",
              //                       maxLines: 1,
              //                       style: TextStyle(
              //                         color: Colors.grey,
              //                         fontSize: 12.sp,
              //                         overflow: TextOverflow.ellipsis,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               Container(
              //                 // color: Colors.white,
              //                 // width: Get.width/6,
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     Text(
              //                       "12:00 PM",
              //                       style: TextStyle(
              //                           color: Colors.grey,
              //                           fontSize: 8.sp,
              //                           fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                     SizedBox(height: Get.width/100,),
              //                     Container(
              //                       height: Get.height/35,
              //                       width: Get.height/35,
              //                       decoration: const BoxDecoration(
              //                           color: Color(0xFF703efe),
              //                           shape: BoxShape.circle
              //                       ),
              //                       alignment: Alignment.center,
              //                       child: Text(
              //                         "3",
              //                         style: TextStyle(
              //                             color: Colors.white,
              //                             fontSize: 9.sp,
              //                             fontWeight: FontWeight.bold
              //                         ),
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //               )
              //             ],
              //           ),
              //           // child: ListTile(
              //           //   leading: CircleAvatar(
              //           //     radius: Get.height/30,
              //           //     backgroundColor: Colors.red,
              //           //   ),
              //           //   title: Text("Dharmik Bhaliya"),
              //           //   subtitle: Text("How Are You ?"),
              //           // ),
              //         ),
              //       ),
              //     );
              //   },
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
