import 'dart:convert';
import 'package:attendance_app_new/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {
  final String apiUrl = 'https://hpcrm.apinext.in/api/v1/signup';
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isSignupLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  bool isSignedUp = false;

  String result = '';

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    numberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> saveToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', value);
  }

  Future<void> postData(context) async {
    isSignupLoading.value = true;
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'name': usernameController.text,
            'email': emailController.text,
            'mobile': numberController.text,
            'password': passwordController.text,
            "status": 1,
          }));
      print(response.body);
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body.toString());
        print(responseData);
        usernameController.clear();
        emailController.clear();
        numberController.clear();
        passwordController.clear();
        Get.to(HomePage());
        isSignedUp = true;
        print(responseData['token']);
        saveToken(responseData['token']);
        Fluttertoast.showToast(
            msg: 'Signed in successfully',
            backgroundColor: Colors.lightGreen,
            fontSize: 22);
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Error Signing in', backgroundColor: Colors.red, fontSize: 22);
    } finally {
      isSignupLoading.value = false;
    }
  }
}
