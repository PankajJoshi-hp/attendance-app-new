import 'package:attendance_app_new/controllers/controller.dart';
import 'package:attendance_app_new/controllers/login_controller.dart';
import 'package:attendance_app_new/screens/sign_up_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool isPasswordVisible = false;
  final LoginController loginControl = Get.put(LoginController());
  final Controller textController = Get.put(Controller());

  void handleVisiblity() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
        height: MediaQuery.sizeOf(context).height -
            MediaQuery.of(context).viewPadding.top,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        child: Form(
            key: loginControl.formKey,
            child: Column(
              // mainAxisSize: MainAxisSize.max,

              spacing: 30,
              children: <Widget>[
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.15),
                Text(
                  'Hi, Welcome Back! 👋',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 8),
                          child: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: loginControl.emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is mandatory';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'example@gmail.com',
                              hintStyle:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                              contentPadding: EdgeInsets.all(22),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0XFF8B0000), width: 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0XFF8B0000), width: 2),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(12)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                      ],
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 8),
                      child: Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: loginControl.passwordController,
                      obscureText: isPasswordVisible ? false : true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is mandatory';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Enter Your Password',
                          hintStyle:
                              TextStyle(fontSize: 16, color: Colors.grey),
                          // style: TextStyle(fontSize: 16, color: Colors.black87),

                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.visibility_off,
                              size: 20,
                            ),
                            onPressed: handleVisiblity,
                            color: Colors.grey,
                          ),
                          contentPadding: EdgeInsets.all(22),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0XFF8B0000), width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0XFF8B0000), width: 2),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 1),
                              borderRadius: BorderRadius.circular(12)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 1),
                              borderRadius: BorderRadius.circular(12))),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: <Widget>[
                //     Expanded(
                //         child: ListTile(
                //       leading: Checkbox(
                //         value: true,
                //         onChanged: (value) => value,
                //       ),
                //       title: Text(
                //         'Remember Me',
                //         style: TextStyle(
                //             fontSize: 18,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.black54),
                //       ),
                //     )),
                //     Text(
                //       'Forgot PassWord?',
                //       style: TextStyle(
                //           fontSize: 20,
                //           fontWeight: FontWeight.w500,
                //           color: Color(0XFFE86969)),
                //     )
                //   ],
                // ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.0009),

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
                            if (loginControl.formKey.currentState!.validate()) {
                              print('Logged in successfully');
                              loginControl.login(context);
                            } else {
                              print('Please fill email field');
                            }
                          },
                          child: !loginControl.isLoginLoading.value
                              ? Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                )
                              : CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                    )),

                Spacer(
                  flex: 1,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: <Widget>[
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Signup',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(SignUpPage());
                          },
                      ),
                    )
                  ],
                )
              ],
            )),
      ))),
    );
  }
}

