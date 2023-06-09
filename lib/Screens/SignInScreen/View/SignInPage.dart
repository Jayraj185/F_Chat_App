import 'package:chat/Screens/HomeScreen/Model/ChatUser.dart';
import 'package:chat/Screens/SignInScreen/Controller/SignInController.dart';
import 'package:chat/Screens/SplashScreen/Controller/SplashController.dart';
import 'package:chat/Utils/FireabseHelper/FireabseHelper.dart';
import 'package:chat/Utils/ToastMessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  SignInController signInController = Get.put(SignInController());
  SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: signInController.SignInkey,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                  height: Get.height / 3,
                  width: Get.width,
                  alignment: Alignment.center,
                  child: Text("Welcome F Chat",style: GoogleFonts.lobster(color: const Color(0xFF703efe), fontSize: 36.sp, fontWeight: FontWeight.bold),)
              ),
            ),
            Container(
              height: Get.height,
              width: Get.width,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(top: Get.width / 1.6, left: Get.width / 12),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 33.sp,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.width / 60),
                          child: Text(
                            "Sign in to your Registration Account",
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: Get.height / 150,
                          width: Get.width / 7,
                          margin: EdgeInsets.only(top: Get.width / 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFF703efe),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.width / 12),
                          child: Text(
                            "Email Address",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: Get.width / 30, right: Get.width / 12),
                            child: TextFormField(
                              controller: signInController.txtSignInEmail,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: const Color(0xFF703efe),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 20),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                        const Color(0xFF703efe)),
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                        const Color(0xFF703efe)),
                                    borderRadius: BorderRadius.circular(9)),
                                hintText: "Enter Email Ex. xyz123@gmail.com",
                                hintStyle: const TextStyle(color: Colors.grey),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: const Color(0xFF703efe),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Your Email";
                                } else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return "Please Enter Valid Email";
                                }
                                return null;
                              },
                            )),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.width / 15),
                          child: Text(
                            "Password",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: Get.width / 30, right: Get.width / 12),
                          child: Obx(
                                () => TextFormField(
                              controller: signInController.txtSignInPass,
                              keyboardType: TextInputType.name,
                              cursorColor: const Color(0xFF703efe),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(top: 20),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                        const Color(0xFF703efe)),
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                        const Color(0xFF703efe)),
                                    borderRadius: BorderRadius.circular(9)),
                                hintText: "Enter Password",
                                hintStyle: const TextStyle(color: Colors.grey),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: const Color(0xFF703efe),
                                ),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      signInController.SignIn_password_vis.value =
                                      !signInController
                                          .SignIn_password_vis.value;
                                    },
                                    child: Icon(
                                      signInController.SignIn_password_vis.value
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: const Color(0xFF703efe),
                                    )),
                              ),
                              obscureText:
                              signInController.SignIn_password_vis.value,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Your Password";
                                } else if (value.length != 6) {
                                  return "Please Enter Maximum 6 Letter";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: Get.width / 30, right: Get.width / 9),
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              "Forgot Password",
                              style: TextStyle(
                                color: const Color(0xFF703efe),
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (signInController.SignInkey.currentState!
                              .validate()) {
                            bool isSignUp = await FirebaseHelper.firebaseHelper.SignInUser(email: signInController.txtSignInEmail.text, password: signInController.txtSignInPass.text);

                            if (isSignUp) {
                              Get.offNamed('Home');
                              ToastMessage(msg: "Login Successful", color: Colors.green);
                              signInController.txtSignInEmail.clear();
                              signInController.txtSignInPass.clear();
                              signInController.SignIn_password_vis.value = true;
                            }
                          } else {
                            ToastMessage(msg: "Please Add Your Email Or Password", color: Colors.red);
                          }

                        },
                        child: Container(
                          height: Get.height / 18,
                          width: Get.width / 3,
                          margin: EdgeInsets.only(
                              top: Get.width / 12, right: Get.width / 12),
                          decoration: BoxDecoration(
                              color: const Color(0xFF703efe),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0xFF703efe),
                                    blurRadius: 15,
                                    offset: Offset(0, 0))
                              ],
                              borderRadius: BorderRadius.circular(30)),
                          alignment: Alignment.center,
                          child: Text(
                            "SIGN IN",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: Get.width / 15, right: Get.width / 12),
                        child: Text(
                          "-Or Sign Up With",
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 9.sp,
                          ),
                        ),
                      ),
                      Container(
                        height: Get.height / 21,
                        width: Get.width / 2,
                        // color: Colors.red,
                        margin: EdgeInsets.only(
                            right: Get.width / 12, top: Get.width / 21),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () async {
                                bool isLogin = await FirebaseHelper.firebaseHelper.GoogleLogIn();
                                if(isLogin)
                                {
                                  Get.offNamed('Home');
                                  ToastMessage(msg: "Congratulation Login Successful", color: Colors.green);
                                  splashController.IsLogin();
                                }
                                else
                                {
                                  ToastMessage(msg: "Failed Login Not Successful", color: Colors.red);
                                }
                              },
                              child: Container(
                                height: Get.height / 23,
                                width: Get.height / 23,
                                alignment: Alignment.center,
                                child:
                                Image.asset("assets/image/google_logo.png"),
                              ),
                            ),
                            Container(
                              height: Get.height / 23,
                              width: Get.height / 23,
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                  horizontal: Get.width / 50),
                              child: Text(
                                "|",
                                style: TextStyle(
                                    color: Colors.black38, fontSize: 21.sp),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                bool isLogin = await FirebaseHelper.firebaseHelper.FacebookLogIn();
                                if(isLogin)
                                {
                                  Get.offNamed('Home');
                                  Get.snackbar('Congratulation', 'Login Is Successful');
                                }
                                else
                                {
                                  Get.snackbar('Failed', 'Login Not Successful');
                                }
                              },
                              child: Container(
                                height: Get.height / 22,
                                width: Get.height / 22,
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "assets/image/facebook.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: Get.width / 21, right: Get.width / 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Don't Have Account",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 10.sp,
                              ),
                            ),
                            SizedBox(
                              width: Get.width / 90,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed('SignUp');
                                signInController.txtSignInEmail.clear();
                                signInController.txtSignInPass.clear();
                                signInController.SignIn_password_vis.value = true;
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: const Color(0xFF703efe),
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
