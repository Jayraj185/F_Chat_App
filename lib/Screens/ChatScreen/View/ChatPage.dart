import 'package:chat/Utils/MessageWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
            child: Row(
              children: [
                IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios_new),color: Colors.white,),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage("https://funkylife.in/wp-content/uploads/2023/01/whatsapp-dp-by-funkylife-561-1.jpg"),
                  radius: Get.width/15,
                ),
                Expanded(
                  child: ListTile(
                    title: Text("Dharmik Bhaliya", maxLines: 1,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                    subtitle: Text("Online", maxLines: 1,style: TextStyle(color: Colors.green,overflow: TextOverflow.ellipsis),),
                  ),
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.videocam_outlined,color: Colors.white,size: 25.sp,)),
                IconButton(onPressed: (){}, icon: Icon(Icons.call_outlined,color: Colors.white,size: 21.sp,)),
              ],
            )
          ),
          Expanded(
            child: Container(
              height: Get.height/1.18,
              width: Get.width,
              padding: EdgeInsets.only(left: Get.width/60, right: Get.width/60, top: Get.width/15),
              decoration: const BoxDecoration(
                  color: Color(0xFFECF4FF),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(45),topRight: Radius.circular(45))
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      reverse: true,
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          MessageWidget.messageWidget.FromSendMessage(msg: "How Are You ?"),
                          MessageWidget.messageWidget.FromSendMessage(msg: "How Are You ?"),
                          MessageWidget.messageWidget.MeSendMessage(msg: "I'm Fine"),
                          MessageWidget.messageWidget.MeSendMessage(msg: "I'm Fine"),
                          MessageWidget.messageWidget.MeSendMessage(msg: "I'm Fine"),
                          MessageWidget.messageWidget.MeSendMessage(msg: "I'm Fine"),
                          MessageWidget.messageWidget.MeSendMessage(msg: "I'm Fine"),
                          MessageWidget.messageWidget.MeSendMessage(msg: "I'm Fine"),
                          MessageWidget.messageWidget.MeSendMessage(msg: "I'm Fine"),
                          MessageWidget.messageWidget.FromSendMessage(msg: "How Are You ?"),
                          MessageWidget.messageWidget.MeSendMessage(msg: "I'm Fine"),
                          MessageWidget.messageWidget.MeSendMessage(msg: "I'm Fine"),
                          MessageWidget.messageWidget.MeSendMessage(msg: "I'm Fine"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Get.width/30,),
                  Container(
                    height: Get.width/8,
                    color: Colors.red,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: Get.width/8,
                            width: Get.width/1.09,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.emoji_emotions_outlined),
                                ),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type Message Here...."
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
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
