import 'package:chat/Screens/AllUsersScreen/Controller/AllUserController.dart';
import 'package:chat/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:chat/Screens/HomeScreen/Model/ChatUser.dart';
import 'package:chat/Utils/FireabseHelper/FireabseHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeController homeController = Get.put(HomeController());
  AllUserController allUserController = Get.put(AllUserController());

  @override
  void initState() {
    super.initState();
    // FirebaseHelper.firebaseHelper.UserDetails();
    // ChatUser chatUser = ChatUser(
    //   id: DateTime.now().millisecondsSinceEpoch.toInt().toString(),
    //   name: FirebaseHelper.user!.displayName,
    //   uid: FirebaseHelper.user!.uid,
    //   about: "Flutter Developer",
    //   email: FirebaseHelper.user!.email,
    //   image: FirebaseHelper.user!.providerData[0].photoURL,
    //   isOnline: false,
    //   lastActive: "Today",
    //   lastMessage: "hii....!",
    // );
    // Map<String,dynamic> userData = chatUser.toJson();
    // FirebaseHelper.firebaseHelper.CreateUser(userData: userData);
    // FirebaseHelper.firebaseHelper.CreateUniqueId(id: id);
    // print("=====")
    // for(var user in allUserController.AllUsersList)
    //   {
    //     if(user.uid != FirebaseHelper.user!.uid)
    //       {
    //         ChatUser chatUser = ChatUser(
    //           id: DateTime.now().millisecondsSinceEpoch.toInt().toString(),
    //           name: FirebaseHelper.user!.displayName,
    //           uid: FirebaseHelper.user!.uid,
    //           about: "Flutter Developer",
    //           email: FirebaseHelper.user!.email,
    //           image: FirebaseHelper.user!.providerData[0].photoURL,
    //           isOnline: false,
    //           lastActive: "Today",
    //           lastMessage: "hii....!",
    //         );
    //         Map<String,dynamic> userData = chatUser.toJson();
    //         FirebaseHelper.firebaseHelper.CreateUser(userData: userData);
    //       }
    //   }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: const Color(0xFF703efe),
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            color: const Color(0xFF703efe),
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(right: Get.width/12,left: Get.width/12,top: Get.width/7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: Get.height/18,
                  width: Get.height/18,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  alignment: Alignment.center,
                  child: Image.asset("assets/image/menu.png",height: Get.width/12,width: Get.width/12,),
                ),
                InkWell(
                  onTap: (){
                    FirebaseHelper.firebaseHelper.SignOutUser();
                    Get.offNamed('SignIn');
                  },
                  child: Text(
                    "Messages",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  height: Get.height/18,
                  width: Get.height/18,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  alignment: Alignment.center,
                  child: Image.asset("assets/image/search.png",height: Get.width/18,width: Get.width/18,),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Get.height/1.18,
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: Get.width/30),
              decoration: const BoxDecoration(
                color: Color(0xFFECF4FF),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(45),topRight: Radius.circular(45))
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseHelper.firebaseHelper.ReadChatUsers(),
                builder: (context, snapshot) {
                  if(snapshot.hasError)
                    {
                      return Center(child: Text("${snapshot.error}"));
                    }
                  else if(snapshot.hasData)
                    {
                      var docs = snapshot.data!.docs;
                      homeController.UserList.value = [];
                      for(var doc in docs)
                        {
                          Map map = doc.data() as Map;
                          ChatUser chatUser = ChatUser.fromJson(map);
                          homeController.UserList.add(chatUser);
                        }
                      print("-===List == ${homeController.UserList}");
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: homeController.UserList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              homeController.chatUser = homeController.UserList[index];
                              Get.toNamed('Chat');
                            },
                            child: Container(
                              height: Get.height/9,
                              width: Get.width,
                              // color: Colors.red,
                              // alignment: Alignment.centerLeft,
                              child: Card(
                                color: const Color(0xFFECF4FF),
                                elevation: 0,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: Get.height/23,
                                      backgroundImage: NetworkImage("${homeController.UserList[index].image}",),
                                      backgroundColor: Colors.white,
                                    ),
                                    Container(
                                      width: Get.width/1.8,
                                      color: const Color(0xFFECF4FF),
                                      // color: Colors.purpleAccent,
                                      padding: EdgeInsets.only(left: Get.width/30),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${homeController.UserList[index].name}",
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          SizedBox(height: Get.width/90,),
                                          Text(
                                            "${homeController.UserList[index].lastMessage}",
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12.sp,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.white,
                                      width: Get.width/7,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${homeController.UserList[index].lastActive}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 8.sp,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          SizedBox(height: Get.width/100,),
                                          Container(
                                            height: Get.height/35,
                                            width: Get.height/35,
                                            decoration: const BoxDecoration(
                                                color: Color(0xFF703efe),
                                                shape: BoxShape.circle
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "3",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9.sp,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                // child: ListTile(
                                //   leading: CircleAvatar(
                                //     radius: Get.height/30,
                                //     backgroundColor: Colors.red,
                                //   ),
                                //   title: Text("Dharmik Bhaliya"),
                                //   subtitle: Text("How Are You ?"),
                                // ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  return Center(child: CircularProgressIndicator(),);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          // FirebaseHelper.firebaseHelper.UserDetails();
          // ChatUser chatUser = ChatUser(
          //   id: DateTime.now().millisecondsSinceEpoch.toInt().toString(),
          //   name: FirebaseHelper.user!.displayName,
          //   uid: FirebaseHelper.user!.uid,
          //   about: "Flutter devloper",
          //   email: FirebaseHelper.user!.email,
          //   image: FirebaseHelper.user!.providerData[0].photoURL,
          //   isOnline: false,
          //   lastActive: "Today",
          //   lastMessage: "hii....!",
          // );
          // Map<String,dynamic> userData = chatUser.toJson();
          // FirebaseHelper.firebaseHelper.CreateChatUser(userData: userData);
          Get.toNamed('AllUsers');
        },
        child: Container(
          height: 10.h,
          width: 20.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFF703efe),
            boxShadow: [
              BoxShadow(color: Colors.deepPurple.shade300, blurRadius: 21)
            ],
          ),
          child: Icon(Icons.add,size: 25.sp,),
        ),
      ),
    );
  }
}
