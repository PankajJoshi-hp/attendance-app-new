import 'dart:convert';

import 'package:attendance_app_new/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final String? apiUrl = dotenv.env['API_KEY_LOGIN'];
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final RxBool isLoginLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  bool isLoggedIn = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> saveToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', value);
  }

  Future<void> login(context) async {
    print(emailController.text);
    print(passwordController.text);
    isLoginLoading.value = true;

    try {
      final response = await http.post(Uri.parse(apiUrl!),
          body: jsonEncode({
            'email': emailController.text,
            'password': passwordController.text
          }),
          headers: {"Content-Type": "application/json"});
      print(response.body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        emailController.clear();
        passwordController.clear();
        Get.off(HomePage());
        isLoggedIn = true;
        print(data['token']);
        saveToken(data['token']);
        Fluttertoast.showToast(
            msg: 'Logged In successfully',
            backgroundColor: Colors.lightGreen,
            fontSize: 22);
      } else {
        Fluttertoast.showToast(
            msg: 'Error logging in', backgroundColor: Colors.red, fontSize: 22);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoginLoading.value = false;
    }
  }
}
