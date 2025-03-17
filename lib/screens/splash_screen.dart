import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:attendance_app_new/main.dart';
import 'package:attendance_app_new/screens/login_page.dart';
import 'package:attendance_app_new/screens/onboarding_one.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync:
          this, // this prevents unnecessary resource usage when the animation is off-screen.
      duration: const Duration(seconds: 2),
    );
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => setState(() {}));
    animationController.forward();

    Timer(const Duration(seconds: 3), navigationPage);
  }

  void navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var getToken = prefs.getString('token');
    SharedPreferences prefsBool = await SharedPreferences.getInstance();
    var getBool = prefsBool.getBool('isLoggedOut');
    // if (getToken != null) {
    //   Get.offAll(() => HomePage());
    // } else if (getBool == true) {
    //   Get.off(LogInPage());
    // } else {
    //   Get.off(() => Onboarding());
    // }
    Get.to(HomePage());
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.redAccent.withValues(red: 0.9)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.45,
              child: const Image(
                image: AssetImage('assets/images/Ellips.png'),
                fit: BoxFit.cover,
              ),
            ),
            AnimatedTextKit(animatedTexts: [
              WavyAnimatedText('Attendance App',
                  textStyle: TextStyle(
                    fontSize: MediaQuery.sizeOf(context).height * 0.045,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                  ),
                  speed: Duration(milliseconds: 150))
            ], repeatForever: true),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.45,
              child: const Image(
                image: AssetImage('assets/images/Ellipse.png'),
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}
