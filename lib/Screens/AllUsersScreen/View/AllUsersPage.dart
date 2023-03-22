import 'package:chat/Screens/AllUsersScreen/Controller/AllUserController.dart';
import 'package:chat/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:chat/Screens/HomeScreen/Model/ChatUser.dart';
import 'package:chat/Utils/FireabseHelper/FireabseHelper.dart';
import 'package:chat/Utils/ToastMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AllUsersPage extends StatefulWidget {
  const AllUsersPage({Key? key}) : super(key: key);

  @override
  State<AllUsersPage> createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  
  AllUserController allUserController = Get.put(AllUserController());
  HomeController homeController = Get.put(HomeController());

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
                InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    height: Get.height/18,
                    width: Get.height/18,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple.shade100,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    alignment: Alignment.center,
                    child: Image.asset("assets/image/back_arrow.png",height: Get.width/18,width: Get.width/18,),
                  ),
                ),
                InkWell(
                  onTap: (){
                    FirebaseHelper.firebaseHelper.SignOutUser();
                    Get.offNamed('SignIn');
                  },
                  child: Text(
                    "All Users",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold
                    ),
                  ),
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
                stream: FirebaseHelper.firebaseHelper.ReadAllUsers(),
                builder: (context, snapshot) {
                  if(snapshot.hasError)
                  {
                    return Center(child: Text("${snapshot.error}"));
                  }
                  else if(snapshot.hasData)
                  {
                    var docs = snapshot.data!.docs;
                    allUserController.AllUsersList.value = [];
                    for(var doc in docs)
                    {
                      Map map = doc.data() as Map;
                      ChatUser chatUser = ChatUser.fromJson(map);
                      allUserController.AllUsersList.add(chatUser);
                    }
                    print("-===List == ${allUserController.AllUsersList}");
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: allUserController.AllUsersList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            FirebaseHelper.firebaseHelper.UserDetails();
                            print("START========== ${homeController.UserList.length}");
                            // for(int i=0; i<allUserController.AllUsersList.length; i++)
                            //   {
                            //     print("USER============== ${allUserController.AllUsersList[i]}");
                            //     if(homeController.UserList[i].uid != allUserController.AllUsersList[index].uid)
                            //     {
                            //       ChatUser chatUser = allUserController.AllUsersList[i];
                            //       Map<String,dynamic> userData = chatUser.toJson();
                            //       print("========== DATATKKk \n${allUserController.AllUsersList[i]}");
                            //       FirebaseHelper.firebaseHelper.CreateChatUser(userData: userData);
                            //       Get.back();
                            //     }
                            //     else{
                            //       ToastMessage(msg: "This User Already Added", color: Colors.red);
                            //     }
                            //   }
                            ChatUser chatUser = allUserController.AllUsersList[index];
                            Map<String,dynamic> userData = chatUser.toJson();
                            print("========== DATATKKk \n${allUserController.AllUsersList[index].name}");
                            FirebaseHelper.firebaseHelper.CreateChatUser(userData: userData);
                            Get.back();
                            print("======= END");
                          },
                          child: Card(
                            color: const Color(0xFFECF4FF),
                            elevation: 0,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: Get.height/30,
                                backgroundImage: NetworkImage("${allUserController.AllUsersList[index].image}"),
                                backgroundColor: Colors.white,
                              ),
                              title: Text("${allUserController.AllUsersList[index].name}"),
                              subtitle: Text("${allUserController.AllUsersList[index].about}"),
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
    );
  }
}
