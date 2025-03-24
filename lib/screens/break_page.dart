import 'package:attendance_app_new/controllers/break_controller.dart';
import 'package:attendance_app_new/reusable_widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animation_list/animation_list.dart';

class BreakPage extends StatefulWidget {
  const BreakPage({super.key});

  @override
  State<BreakPage> createState() => _BreakPageState();
}

class _BreakPageState extends State<BreakPage> {
  final BreakController breakControl = Get.put(BreakController());
  bool isStarted = false;
  String breaksId = '';

  @override
  void initState() {
    super.initState();
    breakControl.getBreak();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.red,
          title: Text(
            'Break'.toUpperCase(),
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
            child: Obx(
          () => !breakControl.isBreakLoading.value
              ? AnimationList(
                  duration: 1500,
                  reBounceDepth: 30,
                  shrinkWrap: true,
                  children: [
                    Column(
                        children: breakControl.breaks
                            .map((breaks) => Card(
                                    child: ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        breaks['name'].toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            // color: Colors.black87,
                                            fontWeight: FontWeight.w500),
                                        // style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        'Duration: ${breaks['duration']} min',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  trailing: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              breaksId != breaks['_id']
                                                  ? WidgetStatePropertyAll(
                                                      AppColors.lightGreen)
                                                  : WidgetStatePropertyAll(
                                                      AppColors.red),
                                          shape: WidgetStatePropertyAll(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7)))),
                                      onPressed: () {
                                        if (breaksId == breaks['_id']) {
                                          breaksId = '';
                                        } else {
                                          breaksId = breaks['_id'];
                                        }
                                        setState(() {
                                          print(breaks['_id']);
                                          isStarted = !isStarted;
                                        });
                                      },
                                      child: Text(
                                        breaksId == breaks['_id']
                                            ? 'End'
                                            : 'Start',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )),
                                  minLeadingWidth: double.infinity,
                                )))
                            .toList())
                  ],
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (_, __) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Shimmer.fromColors(
                      baseColor: Color(0XFFD5D5D5),
                      highlightColor: Color(0XFFFFFFFF),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              height: 12,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            SizedBox(height: 6),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.3,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          ],
                        ),
                        trailing: Container(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          height: 24,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                    ),
                  ),
                ),
        )));
  }
}
