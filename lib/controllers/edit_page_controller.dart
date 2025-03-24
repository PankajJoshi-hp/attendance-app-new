import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditPageController extends GetxController {
  var selectedDate = Rxn<DateTime>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> selectDate(context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2100));
    if (pickedDate != null && pickedDate != selectedDate) {
      DateFormat('yyyy-MM-dd').format(pickedDate);
      selectedDate.value = pickedDate;
    } else {}
  }

  String get formattedDate => selectedDate.value != null
      ? DateFormat('yyyy-MM-dd').format(selectedDate.value!)
      : 'yyyy-mm-dd';
}
