import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class BreakController extends GetxController {
  String? apiUrl = dotenv.env['API_KEY_BREAKS'];
  List<dynamic> breaks = [].obs;
  final RxBool isBreakLoading = true.obs;

  Future<void> getBreak() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var getToken = prefs.getString('token');
    // await Future.delayed(const Duration(seconds: 1));

    try {
      isBreakLoading.value = true;
      final response = await http.get(Uri.parse(apiUrl!), headers: {
        "Content-Type": "application/json",
        "Cookie": 'token=$getToken',
      });
      print(response.body);

      if (response.statusCode == 200) {
        Map jsonData = json.decode(response.body);

        breaks = jsonData['data'];

        print(breaks);
        print('Success');
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isBreakLoading.value = false;
    }
  }
}
