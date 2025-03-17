import 'package:animation_list/animation_list.dart';
import 'package:attendance_app_new/controllers/controller.dart';
import 'package:attendance_app_new/controllers/deviceStatusController.dart';
import 'package:attendance_app_new/controllers/language_control/translate.dart';
import 'package:attendance_app_new/controllers/logout_controller.dart';
import 'package:attendance_app_new/controllers/profile_page_controller.dart';
import 'package:attendance_app_new/reusable_widgets/app_colors.dart';
import 'package:attendance_app_new/reusable_widgets/push_notification_service.dart';
import 'package:attendance_app_new/screens/profile_page.dart';
import 'package:attendance_app_new/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animations/animations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await PushNotificationService().initNotifications();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var getToken = prefs.getString('token');
  await dotenv.load(fileName: ".env");
  runApp(MyApp(
    getToken: getToken,
  ));
}

class MyApp extends StatefulWidget {
  final dynamic getToken;
  const MyApp({super.key, required this.getToken});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeMode _themeMode = ThemeMode.system;
  final ProfilePageController profileController =
      Get.put(ProfilePageController());

  @override
  void initState() {
    super.initState();
    profileController.loadLocale();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return profileController.isLoading.value
          ? MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          : GetMaterialApp(
              translations: Translate(),
              locale: profileController.locale.value,
              fallbackLocale: Locale('en', 'US'),
              theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Raleway'),
              darkTheme: ThemeData.dark(),
              themeMode: _themeMode,
              home: SplashScreen(),
            );
    });
  }
}

class HomePage extends StatefulWidget {
  // final toggleTheme;
  const HomePage({
    super.key,
    //  this.toggleTheme
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LogoutController logoutControl = Get.put(LogoutController());
  Controller reportControl = Get.put(Controller());
  DeviceStatusController deviceInfoControl = Get.put(DeviceStatusController());

  String? selectedButton;
  String _lastMessage = '';

  @override
  void initState() {
    super.initState();
    PushNotificationService.messageStreamController.listen((message) {
      setState(() {
        if (message.notification != null) {
          _lastMessage = 'Received a notification message:'
              '\nTitle=${message.notification?.title},'
              '\nBody=${message.notification?.body},'
              '\nData=${message.data}';
        } else {
          _lastMessage = 'Received a data message: ${message.data}';
        }
      });
    });
  }

  void openProfilePage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => ProfilePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 24,
                    child: Image.asset('assets/images/human.png'),
                  ),
                  SizedBox(width: 12),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Hello'.tr,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Test User...'.tr,
                          style: TextStyle(
                              // color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        )
                      ]),
                ],
              ),
              InkWell(
                child: Image.asset(
                  'assets/images/user.png',
                  width: 35,
                  height: 35,
                ),
                onTap: () => openProfilePage(context),
              )
            ]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
            AnimationList(
              duration: 1500,
              reBounceDepth: 30,
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: reportControl.reportButtons
                      .map((button) => GestureDetector(
                            onTap: () {
                              if (button['id'] != 2) {
                                reportControl.focusTextField(context);
                                selectedButton = button['type'];
                              } else {
                                selectedButton = null;
                                Navigator.of(context)
                                    .push(reportControl.createRoute());
                                // Get.to(BreakPage());
                              }
                              // controller
                              //     .updateReport(controller.reportController.text);
                              print("${button['type']} Clicked");
                              // controller.selectedId = button['id'];
                              setState(() {});
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.32,
                              height: 100,
                              decoration: BoxDecoration(
                                color: button['background_color'],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(button['icon'],
                                      size: 40, color: Colors.white),
                                  SizedBox(height: 8),
                                  Text(button['type'.tr],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                )
              ],
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Get.to(MapsDemo());
            //   },
            //   style: ButtonStyle(
            //       backgroundColor: WidgetStatePropertyAll(Colors.blueGrey)),
            //   child: Text('Map page'),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     Get.to(AllUsersPage());
            //   },
            //   style: ButtonStyle(
            //       backgroundColor: WidgetStatePropertyAll(Colors.grey[100])),
            //   child: Text('All Users'),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     Get.to(PaginationExample());
            //   },
            //   style: ButtonStyle(
            //       backgroundColor: WidgetStatePropertyAll(Colors.grey[100])),
            //   child: Text('Pagination Example'),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     Get.to(SearchableDropdown());
            //   },
            //   style: ButtonStyle(
            //       backgroundColor: WidgetStatePropertyAll(Colors.grey[100])),
            //   child: Text('Searchable Dropdown'),
            // ),
            // // Text('Last message from Firebase Messaging:',
            // //     style: Theme.of(context).textTheme.titleLarge),
            // Text(_lastMessage, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
      bottomNavigationBar: selectedButton == null
          ? SizedBox.shrink()
          : Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Form(
                        child: TextFormField(
                          // maxLines: 2,
                          focusNode: reportControl.focusNode,
                          controller: reportControl.reportController,
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Your Text Here..',
                            hintStyle:
                                TextStyle(fontSize: 16, color: Colors.grey),
                            contentPadding: EdgeInsets.all(20),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.lightBlue,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(10),
                      child: IconButton(
                          onPressed: () {
                            // print(jsonEncode(deviceInfoControl.infoObject));
                            // print('------------------------------');
                            reportControl.sendReport(selectedButton);
                          },
                          icon: Icon(Icons.send_rounded,
                              size: 32, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}