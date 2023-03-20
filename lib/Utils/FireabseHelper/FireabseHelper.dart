import 'package:chat/Utils/ToastMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseHelper
{
  //SingleTone Constructor
  FirebaseHelper._();

  static FirebaseHelper firebaseHelper = FirebaseHelper._();

  //Create FirebaseAuth Object
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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
  Future<bool> CheckSignIn()
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
  }
}