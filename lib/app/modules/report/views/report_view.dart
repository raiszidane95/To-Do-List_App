import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../core/utils/extension.dart';
import '../../../core/value/colors.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  final homeCtrl = Get.find<HomeController>();
  ReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          var createdTasks = homeCtrl.getTotalTask();
          var completedTasks = homeCtrl.getTotalDoneTask();
          var liveTasks = createdTasks - completedTasks;
          var percent = (completedTasks / createdTasks * 100).toStringAsFixed(0);
          return ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(4.0.wp),
                child: Text(
                  'My Report',
                  style: TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                child: Text(DateFormat.yMMMMd().format(DateTime.now()),
                    style: TextStyle(fontSize: 14.0.sp, color: Colors.grey)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 3.0.wp,
                  horizontal: 4.0.wp,
                ),
                child: const Divider(thickness: 2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 3.0.wp,
                  horizontal: 4.0.wp,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatus(Colors.green, liveTasks, 'Live Tasks'),
                    _buildStatus(Colors.orange, completedTasks, 'Completed'),
                    _buildStatus(Colors.blue, createdTasks, 'Created'),
                  ],
                ),
              ),
              SizedBox(height: 8.0.wp),
              UnconstrainedBox(
                child: SizedBox(
                  height: 70.0.wp,
                  width: 70.0.wp,
                  child: CircularStepProgressIndicator(
                    totalSteps: createdTasks == 0 ? 1 : createdTasks,
                    currentStep: completedTasks,
                    stepSize: 20,
                    selectedColor: green,
                    unselectedColor: Colors.grey.shade200,
                    padding: 0,
                    width: 150,
                    height: 150,
                    selectedStepSize: 22,
                    roundedCap: (_, __) => true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${createdTasks == 0 ? 0 : percent} %',
                          style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
                        ),
                        Gap(1.0.wp),
                        Text(
                          'Efficiency',
                          style: TextStyle(
                              fontSize: 12.0.sp, color: Colors.grey, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Row _buildStatus(Color color, int number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 3.0.wp,
          width: 3.0.wp,
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(width: 0.5.wp, color: color)),
        ),
        SizedBox(width: 3.0.wp),
        Column(
          children: [
            Text('$number', style: TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.bold)),
            Gap(2.0.wp),
            Text(text, style: TextStyle(fontSize: 12.0.sp, color: Colors.grey))
          ],
        ),
      ],
    );
  }
}
