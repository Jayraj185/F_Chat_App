import 'dart:convert';

import 'package:chat/Screens/ChatScreen/Model/MessageModel.dart';
import 'package:chat/Screens/HomeScreen/Model/ChatUser.dart';
import 'package:chat/Utils/ToastMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper
{
  //SingleTone Constructor
  FirebaseHelper._();

  static User? user;
  static FirebaseHelper firebaseHelper = FirebaseHelper._();

  //Create FirebaseAuth Object
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //Create FirebaseFirestore Object
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //Create Firebase Messaging Object
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  //Create Flutter Local Notifications Plugin Object
  FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// =========== ************* LOGIN SYSTEM IN FIREBASE AUTHENTICATION ********** ================
  //SignUp User In FirebaseAuth
  Future<bool> SignUpUser({required String email, required String password})
  async {
    bool isSignUp = false;
    await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      isSignUp = true;
    }).catchError((error){
      isSignUp = false;
      ToastMessage(msg: error, color: Colors.red);
    });
    return isSignUp;
  }

  //SignIn User In FirebaseAuth
  Future<bool> SignInUser({required String email, required String password})
  async {
    bool isSignUp = false;
    await firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((value) {
      isSignUp = true;
    }).catchError((error){
      isSignUp = false;
      ToastMessage(msg: error, color: Colors.red);
    });
    return isSignUp;
  }

  //Check User Login
  Future<bool>  CheckSignIn()
  async {

    if(await firebaseAuth.currentUser != null)
    {
      return true;
    }
    return false;

  }

  //Sign Out User
  Future<void> SignOutUser()
  async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<bool> UserExist() async
  {
    UserDetails();
    print("=========== USER EXIST === ${(await firebaseFirestore.collection("AllUsers").doc(user!.uid).get()).exists}");
    return (await firebaseFirestore.collection("AllUsers").doc(user!.uid).get()).exists;
  }

  //Login With Google
  Future<bool> GoogleLogIn()
  async {

    bool isLogin = false;
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential)
        .then((value) {
      isLogin = true;

    })
        .catchError((error) {
      isLogin = false;
    });

    return isLogin;
  }

  //Login With Facebook
  Future<bool> FacebookLogIn()
  async {

    bool isLogin = false;
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    FirebaseAuth.instance.signInWithCredential(facebookAuthCredential)
        .then((value) {
      isLogin = true;
    })
        .catchError((error) {
      print("===== $error");
      isLogin = false;
    });
    print("===== $isLogin");

    return isLogin;
  }

  //Read User Details
  void UserDetails()
  {
    user = firebaseAuth.currentUser;
    print("======= $user");
  }



  /// =================== ************* FIREBASE FIRESTORE ********** =======================




  /// =================== ************* CHAT USER FIREBASE FIRESTORE ********** =======================

  //Insert Chat User Data In Firebase Firestore
  void CreateChatUser({required Map<String,dynamic> userData}) async
  {
    UserDetails();
    print("========= UID == ${user!.uid}\nDATA=== ${userData['uid']}");
    await firebaseFirestore.collection("ChatUser").doc(userData['uid']).set(userData);
  }

  //Read Chat User Data In Firebase Firestore
  Stream<QuerySnapshot<Map<String, dynamic>>> ReadChatUsers()
  {
    UserDetails();
    // return firebaseFirestore.collection('Users').doc(user!.uid).collection("ChatUser").snapshots();
    return firebaseFirestore.collection("ChatUser").where("uid",isNotEqualTo: user!.uid,).snapshots();
  }

  //Delete Chat User Data In Firebase Firestore
  void DeleteChatUser({required String id}) async
  {
    UserDetails();
    await firebaseFirestore.collection("ChatUser").doc(id).delete();
  }

  //Update Chat User Data In Firebase Firestore
  void UpdateChatUser({required bool isOnline}) async
  {
    UserDetails();
    await firebaseFirestore.collection("ChatUser").doc(user!.uid).update(
        {
          'isOnline' : isOnline,
          'lastActive' : DateTime.now().millisecondsSinceEpoch.toString()
        });
  }

  //Get User Information In Firebase Firestore
  Stream<QuerySnapshot<Map<String, dynamic>>> GetUserInfo({required ChatUser chatUser})
  {
    UserDetails();
    return firebaseFirestore.collection("ChatUser").where("uid",isEqualTo: chatUser.uid).snapshots();

  }




  /// =================== ************* ALL USERS FIREBASE FIRESTORE ********** =======================


  //Insert All User in One User Data In Firebase Firestore
  Future<void> CreateUser()
  async {
    UserDetails();
    FirebaseHelper.firebaseHelper.UserDetails();
    String? token = await FirebaseMessaging.instance.getToken();
    print("================ TOKEN \n======== $token");
    ChatUser chatUser = ChatUser(
      id: DateTime.now().millisecondsSinceEpoch.toInt().toString(),
      name: FirebaseHelper.user!.displayName,
      uid: FirebaseHelper.user!.uid,
      about: "Hey I'm Using F Chat... 😊",
      email: FirebaseHelper.user!.email,
      image: FirebaseHelper.user!.providerData[0].photoURL,
      isOnline: false,
      lastActive: "${DateTime.now().millisecondsSinceEpoch}",
      lastMessage: "Hey Guys....!",
      Tocken: token,
    );
    Map<String,dynamic> userData = chatUser.toJson();

    print("========= UID == ${user!.uid}\nDATA=== $userData");

    await firebaseFirestore.collection('AllUsers').doc(user!.uid).set(userData);
  }

  //Read All Users Data In Firebase Firestore
  Stream<QuerySnapshot<Map<String, dynamic>>> ReadAllUsers()
  {
    UserDetails();
    // return firebaseFirestore.collection('AllUsers').snapshots();
    return firebaseFirestore.collection('AllUsers').where("uid",isNotEqualTo: user!.uid).snapshots();
  }

  //Delete All User in One User Data In Firebase Firestore
  void DeleteUser({required String id}) async
  {
    UserDetails();
    await firebaseFirestore.collection('AllUsers').doc(id).delete();
  }

  //Update All User in One User Data In Firebase Firestore
  void UpdateUser({required String id, required Map<String,dynamic> userData}) async
  {
    UserDetails();
    await firebaseFirestore.collection('AllUsers').doc(id).update(userData);
  }



  /// =================== ************* MESSAGES IN FIREBASE FIRESTORE ********** =======================


  String CreateUniqueId({required String id})
  {
    print("============== Unique String ID ${id.hashCode}\n============== Unique String ID ${user!.uid.hashCode}\nCompress ${id.hashCode<=user!.uid.hashCode}\nCondition Compress ${id.hashCode<=user!.uid.hashCode ? "${user!.uid}_$id" : "${id}_${user!.uid}"}");
    return "${id.hashCode<=user!.uid.hashCode ? "${user!.uid}_$id" : "${id}_${user!.uid}"}";
  }
  //Insert Message Data In Firebase Firestore
  void SendMessage({required Map<String,dynamic> userData, required String message}) async
  {
    UserDetails();
    print("========= UID == ${user!.uid}\nDATA=== $userData");
    String time = DateTime.now().millisecondsSinceEpoch.toString();

    MessageModel messageModel = MessageModel(
      message: message,
      toId: userData['uid'],
      fromId: user!.uid,
      sent: time,
      read: "",
      type: Type.text,
    );
    Map<String,dynamic> userMessage = messageModel.toJson();

    String uniqueId = CreateUniqueId(id: userData['uid']);

    await firebaseFirestore.collection("Chats").doc(uniqueId).collection("Messages").doc(time).set(userMessage);
  }

  //Read Message Data In Firebase Firestore
  Stream<QuerySnapshot<Map<String, dynamic>>> ReadMessage({required Map<String,dynamic> userData})
  {
    UserDetails();
    // return firebaseFirestore.collection('AllUsers').snapshots();

    String uniqueId = CreateUniqueId(id: userData['uid']);

    return firebaseFirestore.collection("Chats").doc(uniqueId).collection("Messages").orderBy('sent',descending: true).snapshots();
  }

  //Delete Message in One User Data In Firebase Firestore
  void DeleteMessage({required String id, required Map<String,dynamic> userData}) async
  {
    UserDetails();
    String uniqueId = CreateUniqueId(id: userData['uid']);
    firebaseFirestore.collection("Chats").doc(uniqueId).collection("Messages").doc(id).delete();
  }

  //Update Message Data In Firebase Firestore
  // void UpdateMessage({required String id, required Map<String,dynamic> userData}) async
  // {
  //   UserDetails();
  //   // await firebaseFirestore.collection("Chats").doc(id).update(userData);
  // }

  //Update Message Data Read Or Not In Firebase Firestore
  void UpdateMessage({required MessageModel messageModel}) async
  {
    UserDetails();
    Map<String,dynamic> userMessage = messageModel.toJson();
    String uniqueId = CreateUniqueId(id: messageModel.fromId!);
    // print("====== ${messageModel.fromId}\n====== MESAGE $userMessage");
    // print("========= UNIQID $uniqueId ");
    firebaseFirestore.collection("Chats").doc(uniqueId).collection("Messages").doc(messageModel.sent).update(userMessage);
  }

  //Read Last Message In Firebase Firestore
  Stream<QuerySnapshot<Map<String, dynamic>>> ReadLastMessage({required ChatUser userData})
  {
    UserDetails();
    // return firebaseFirestore.collection('AllUsers').snapshots();

    String uniqueId = CreateUniqueId(id: userData.uid!);

     return firebaseFirestore.collection("Chats").doc(uniqueId).collection("Messages").orderBy('sent',descending: true).limit(1).snapshots();
  }






  /// =================== ************* NOTIFICATION MESSAGES IN FIREBASE FIRESTORE ********** =======================


  // Create FirebaseNotification Method
  Future<void> FirebaseNotification()
  async {
    NotificationSettings notificationSettings =
    await firebaseMessaging.requestPermission(
      alert: true,
      provisional: false,
      criticalAlert: false,
      announcement: true,
      badge: true,
      carPlay: false,
      sound: true
    );
    InitializeNotification();
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification != null)
        {
          String? body = message.notification!.body;
          String? title = message.notification!.title;

          ShowChatNotificationMessage(title: title!, body: body!);
        }
    });
  }

  // Initialize Firebase Notification
  void InitializeNotification()
  {
    AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("logo");
    DarwinInitializationSettings iOSInitializationSettings = DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings,iOS: iOSInitializationSettings);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Show Chat Notification On Firebase
  Future<void> ShowChatNotificationMessage({required String title, required String body})
  async {

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails("1", "Android",importance: Importance.high,priority: Priority.max);

    DarwinNotificationDetails iOSNotificationDetails = DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails,iOS: iOSNotificationDetails);

    await flutterLocalNotificationsPlugin.show(1, title, body, notificationDetails);


  }



}