import 'package:attendance_app_new/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController extends GetxController {
  final String? apiUrl = dotenv.env['API_KEY_LOGOUT'];
  final RxBool isLogoutLoading = false.obs;
  final bool isLoggedOut = false;

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var getToken = prefs.getString('token');

    isLogoutLoading.value = true;

    try {
      // await Future.delayed(Duration(seconds: 2));
      final response = await http.get(
        Uri.parse(apiUrl!),
        headers: {
          "Content-Type": "application/json",
          "Cookie": 'token=$getToken', // Attach cookies
        },
      );
      // print('-------------------------');
      // print(response.body);
      // print('-------------------------');
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        Get.off(LogInPage());
        final prefsBool = await SharedPreferences.getInstance();
        prefsBool.setBool('isLoggedOut', true);
        print('Token cleared');
      } else {
        Fluttertoast.showToast(
            msg: 'Error: ${response.statusCode}',
            backgroundColor: Colors.red,
            fontSize: 20);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLogoutLoading.value = false;
    }
  }

  // void _updateIsLoading(bool currentStatus) {
  //   isLoading = currentStatus;
  //   update();
  // }
}
