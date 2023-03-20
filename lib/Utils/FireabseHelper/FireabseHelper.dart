import 'package:chat/Utils/ToastMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper
{
  //SingleTone Constructor
  FirebaseHelper._();

  static User? user;
  static FirebaseHelper firebaseHelper = FirebaseHelper._();

  //Create FirebaseAuth Object
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /// =========== ************* LOGIN SYSTEM ********** ================
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
  }



  /// =========== ************* FIREBASE FIRESTORE ********** ================


}