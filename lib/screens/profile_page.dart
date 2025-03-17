import 'package:attendance_app_new/controllers/logout_controller.dart';
import 'package:attendance_app_new/controllers/profile_page_controller.dart';
import 'package:attendance_app_new/screens/edit_profile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animations/animations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  LogoutController logoutControl = Get.put(LogoutController());
  ProfilePageController profileController = Get.put(ProfilePageController());

  List<Map> profileOptions = [
    {'icon': Icons.language, 'name': 'Language'},
    {'icon': Icons.logout, 'name': 'Logout'},
  ];

  void handleLogout() {
    logoutControl.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: 60),
          child: Text(
            'Profile',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.sizeOf(context).height * 0.14,
              margin: EdgeInsets.only(bottom: 40),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0XFFCCCCCC),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10.0), // Uniform radius
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.35,
                    child: Image.asset('assets/images/user.png'),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Test User',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text.rich(
                        TextSpan(
                            text: 'Edit Profile',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(editProfileRoute());
                              }),
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      )
                    ],
                  ))
                ],
              ),
            ),
            Column(
              children: profileOptions.map((option) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: option['name'] == 'Language'
                      ? OpenContainer(
                          transitionType: ContainerTransitionType.fadeThrough,
                          closedElevation: 0,
                          closedColor: Colors.transparent,
                          openColor: Colors.white,
                          closedBuilder: (_, openContainer) {
                            return InkWell(
                              onTap: openContainer,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(option['icon'],
                                          size: 28,
                                          color: Colors.deepOrangeAccent),
                                      SizedBox(width: 10),
                                      Text(option['name'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              )),
                                    ],
                                  ),
                                  Icon(Icons.arrow_right, size: 28),
                                ],
                              ),
                            );
                          },
                          openBuilder: (_, closeContainer) {
                            return Scaffold(
                              appBar: AppBar(
                                backgroundColor: Colors.blue,
                                title: Text("Select Language"),
                                leading: IconButton(
                                  onPressed: closeContainer,
                                  icon: Icon(Icons.arrow_back,
                                      color: Colors.white),
                                ),
                              ),
                              body: ListView(
                                children: profileController.list.map((lang) {
                                  return ListTile(
                                    title: Text(lang['name']),
                                    onTap: () async {
                                      Locale selectedLocale = lang['language'];
                                      Get.updateLocale(selectedLocale);

                                      final prefs = await SharedPreferences.getInstance();
                                      prefs.setString('savedLang', selectedLocale.toString());
                                    },
                                  );
                                }).toList(),
                              ),
                            );
                          },
                        )
                      : InkWell(
                          onTap: () {
                            if (option['name'] == 'Logout') {
                              logoutControl.logout();
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(option['icon'],
                                      size: 28,
                                      color: Colors.deepOrangeAccent),
                                  SizedBox(width: 10),
                                  Text(option['name'],
                                      style: TextStyle(
                                          fontSize: 20)),
                                ],
                              ),
                              Icon(Icons.arrow_right, size: 28),
                            ],
                          ),
                        ),
                );
              }).toList(),
            )
          ],
        ),
      )));
  }
}

Route editProfileRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const EditProfile(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}
