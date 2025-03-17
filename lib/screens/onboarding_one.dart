import 'package:attendance_app_new/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A self-contained PageView example with a Scaffold and embedded PageIndicator.
class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _PageViewExampleState();
}

class _PageViewExampleState extends State<Onboarding>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      'imagePath': 'assets/images/Object.png',
      'title': "Welcome To Our Attendance Tracking App",
      'description':
          'Transforming lives by offering hope and opportunities for recovery, wellness, and independence.',
    },
    {
      'imagePath': 'assets/images/Object2.png',
      'title': "Track Attendance Easily",
      'description':
          'Seamlessly manage and monitor attendance with our user-friendly app.',
    },
    {
      'imagePath': 'assets/images/Object3.png',
      'title': "Stay Organized",
      'description':
          'Get real-time attendance insights and boost productivity.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.redAccent.withValues(red: 0.9)),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.45,
                  child: Image(
                    image: AssetImage('assets/images/Ellips.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.45,
                  child: Image(
                    image: AssetImage('assets/images/Ellipse.png'),
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            Transform.translate(
              offset: Offset(0, -60),
              child: PageView.builder(
                controller: _pageViewController,
                itemCount: _pages.length,
                onPageChanged: _handlePageViewChanged,
                itemBuilder: (context, index) {
                  return _buildPage(
                    imagePath: _pages[index]['imagePath']!,
                    title: _pages[index]['title']!,
                    description: _pages[index]['description']!,
                  );
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.85,
              height: MediaQuery.sizeOf(context).height * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentPageIndex != 2
                      ? TextButton(
                          onPressed: () => Get.off(LogInPage()),
                          child: const Text(
                            "Skip",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      : SizedBox(
                          width: 65,
                          height: 10,
                        ),
                  TabPageSelector(
                    controller: _tabController,
                    color: Colors.white,
                    selectedColor: Colors.grey[600],
                    borderStyle: BorderStyle.none,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPageIndex == 2) {
                        Get.off(LogInPage());
                        return;
                      }
                      
                      _updateCurrentPageIndex(_currentPageIndex + 1);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.white,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({
    required String imagePath,
    required String title,
    required String description,
  }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.5,
                child: Image.asset(imagePath),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.85,
                child: Column(
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}






// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';


// class OnboardingOne extends StatefulWidget {
//   const OnboardingOne({super.key});

//   @override
//   State<OnboardingOne> createState() => _OnboardingOneState();
// }

// class _OnboardingOneState extends State<OnboardingOne> {
//   final PageController _controller = PageController();
//   int currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.9)),
//         child: Stack(
//           children: [
//             Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 SizedBox(
//                   width: double.infinity,
//                   height: MediaQuery.sizeOf(context).height * 0.45,
//                   child: Image(
//                     image: AssetImage('assets/images/Ellips.png'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   height: MediaQuery.sizeOf(context).height * 0.45,
//                   child: Image(
//                     image: AssetImage('assets/images/Ellipse.png'),
//                     fit: BoxFit.cover,
//                   ),
//                 )
//               ],
//             ),
//             Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 spacing: 20,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       SizedBox(
//                         width: MediaQuery.sizeOf(context).width * 0.9,
//                         height: MediaQuery.sizeOf(context).height * 0.07,
//                       ),
//                       SizedBox(
//                         width: MediaQuery.sizeOf(context).width,
//                         height: MediaQuery.sizeOf(context).height * 0.5,
//                         child: Image.asset('assets/images/Object.png'),
//                       ),
//                       SizedBox(
//                         width: MediaQuery.sizeOf(context).width * 0.9,
//                         height: MediaQuery.sizeOf(context).height * 0.03,
//                       ),
//                       SizedBox(
//                         width: MediaQuery.sizeOf(context).width * 0.85,
//                         child: Column(
//                           spacing: 14,
//                           children: <Widget>[
//                             Text(
//                               "Welcome To Our Attendance Tracking App",
//                               style: TextStyle(
//                                   fontSize: 32, fontWeight: FontWeight.bold),
//                               textAlign: TextAlign.center,
//                             ),
//                             Text(
//                               'Transforming lives by offering hope and opportunities for recovery, wellness, and independence.',
//                               textAlign: TextAlign.center,
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),

//                   SizedBox(
//                     width: MediaQuery.sizeOf(context).width * 0.85,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextButton(
//                           onPressed: () {},
//                           child: const Text(
//                             "Skip",
//                             style: TextStyle(color: Colors.white, fontSize: 16),
//                           ),
//                         ),
//                         SmoothPageIndicator(
//                           controller: _controller,
//                           count: 3,
//                           effect: const WormEffect(
//                             activeDotColor: Colors.white,
//                             dotColor: Colors.white38,
//                             dotHeight: 8,
//                             dotWidth: 16,
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             shape: const CircleBorder(),
//                             padding: const EdgeInsets.all(16),
//                             backgroundColor: Colors.white,
//                           ),
//                           child: const Icon(
//                             Icons.arrow_forward,
//                             color: Colors.purple,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
