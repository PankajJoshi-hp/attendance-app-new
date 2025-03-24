import 'dart:io';

import 'package:attendance_app_new/controllers/edit_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String gender = 'Male';
  final picker = ImagePicker();
  File? image;
  final EditPageController editController = Get.put(EditPageController());

  Future pickImageFromCamera() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile == null) return;
      setState(() {
        image = File(pickedFile.path);
      });
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('setImage', pickedFile.path);
      print("Image saved at: ${pickedFile.path}");
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageFromGallery() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;
      setState(() {
        image = File(pickedFile.path);
      });
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('setImage', pickedFile.path);
      print("Image saved at: ${pickedFile.path}");
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.15,
          child: Center(
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    pickImageFromCamera();
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.photo_camera,
                      size: 30,
                    ),
                    title: Text(
                      'Take a picture',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    pickImageFromGallery();
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.photo_album,
                      size: 30,
                    ),
                    title: Text('Upload from gallery',
                        style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // @override
  // void dispose() {
  //   editController.nameController.dispose();
  //   editController.numberController.dispose();
  //   editController.emailController.dispose();
  //   super.dispose();
  // }

  // void saveData(){
  //   setState(() {
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: 60),
          child: Text(
            'Edit Profile',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.32,
                    height: MediaQuery.sizeOf(context).height * 0.15,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: image != null
                            ? FileImage(image!) as ImageProvider
                            : const AssetImage('assets/images/user.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.edit,
                            size: 25, color: Colors.redAccent),
                        onPressed: showBottomSheet,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Full Name",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  TextFormField(
                    controller: editController.nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name field shouldn't be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Your name',
                        hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                        contentPadding: EdgeInsets.all(16),
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
                  const SizedBox(height: 15),
                  const Text("Date of Birth",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  GestureDetector(
                    onTap: () => editController.selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Obx(
                        () => Text(
                          editController.formattedDate,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text("Gender",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              gender = "Male";
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                              color: gender == "Male"
                                  ? Colors.grey.shade200
                                  : Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                  value: "Male",
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value.toString();
                                    });
                                  },
                                ),
                                const Text("Male"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              gender = "Female";
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                              color: gender == "Female"
                                  ? Colors.grey.shade200
                                  : Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                  value: "Female",
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value.toString();
                                    });
                                  },
                                ),
                                const Text("Female"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text("Mobile No",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  TextFormField(
                    controller: editController.numberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Mobile No. field shouldn't be empty";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: 'XXXXXXXXXX',
                        hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                        contentPadding: EdgeInsets.all(16),
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
                  const SizedBox(height: 15),
                  const Text("Email",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  TextFormField(
                    controller: editController.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email field shouldn't be empty";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'xxx@gmail.com',
                        hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                        contentPadding: EdgeInsets.all(16),
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
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text("Cancel",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 16)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text("Save",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
