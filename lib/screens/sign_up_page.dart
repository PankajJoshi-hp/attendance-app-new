import 'package:attendance_app_new/controllers/signup_controller.dart';
import 'package:attendance_app_new/screens/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // const SignUpPage({super.key});
  final SignupController signupControl = Get.put(SignupController());
  bool isPasswordVisible = false;

  void handleVisiblity() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          width: double.infinity,
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 30,
              children: <Widget>[
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),
                Column(
                  children: <Widget>[
                    Text(
                      'Create an account',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Start writing your todos today!',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: TextFormField(
                    controller: signupControl.usernameController,
                    decoration: InputDecoration(
                        label: Text(
                          'Enter your username',
                          style: TextStyle(fontSize: 16),
                        ),
                        contentPadding: EdgeInsets.all(22),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black54, width: 1),
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black54, width: 1),
                            borderRadius: BorderRadius.circular(12))),
                  ),
                ),
                TextFormField(
                  controller: signupControl.emailController,
                  decoration: InputDecoration(
                      label: Text(
                        'Enter Your Email',
                        style: TextStyle(fontSize: 16),
                      ),
                      contentPadding: EdgeInsets.all(22),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black54, width: 1),
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black54, width: 1),
                          borderRadius: BorderRadius.circular(12))),
                ),
                TextFormField(
                  controller: signupControl.numberController,
                  decoration: InputDecoration(
                      label: Text(
                        'Enter Your Phone Number',
                        style: TextStyle(fontSize: 16),
                      ),
                      contentPadding: EdgeInsets.all(22),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black54, width: 1),
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black54, width: 1),
                          borderRadius: BorderRadius.circular(12))),
                ),
                TextFormField(
                  controller: signupControl.passwordController,
                  obscureText: isPasswordVisible ? false : true,
                  decoration: InputDecoration(
                      label: Text(
                        'Enter Your Password',
                        style: TextStyle(fontSize: 16),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.visibility_off,
                          size: 20,
                        ),
                        onPressed: handleVisiblity,
                        color: Colors.black54,
                      ),
                      contentPadding: EdgeInsets.all(22),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black54, width: 1),
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black54, width: 1),
                          borderRadius: BorderRadius.circular(12))),
                ),
                Obx(() => SizedBox(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.065,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Color(0XFF0E64D2)),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                          ),
                          onPressed: () {
                            signupControl.postData(context);
                          },
                          child: signupControl.isSignupLoading.value == false
                              ? Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                )
                              : CircularProgressIndicator()),
                    )),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: <Widget>[
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                          decoration: TextDecoration.underline),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Login',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(LogInPage());
                          },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
