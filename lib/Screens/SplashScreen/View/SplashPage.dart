import 'package:chat/Screens/SplashScreen/Controller/SplashController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  SplashController splashController = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    splashController.IsLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset("assets/image/splashlogo.png",height: Get.width/2.1,width: Get.width/2.1,)
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: Get.width/8,),
              child: Text(
                "  from",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 9.sp,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: Get.width/15),
              child: Text(
                "Jayraj",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF703efe),
                  fontSize: 15.sp
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: Get.width/4),
              child: CircularProgressIndicator(color: const Color(0xFF703efe),)
            ),
          ),
        ],
      ),
    );
  }
}
