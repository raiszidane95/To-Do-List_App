import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/utils/extension.dart';
import '../../../core/value/colors.dart';
import '../../home/controllers/home_controller.dart';

class DoneList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  DoneList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doneTodos.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 2.0.wp),
                child: Text(
                  'Completed(${homeCtrl.doingTodos.length})',
                  style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                ),
              ),
              ...homeCtrl.doneTodos
                  .map(
                    (element) => Dismissible(
                      key: ObjectKey(element),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => homeCtrl.deleteDoneTodo(element),
                      background: Container(
                        // margin: EdgeInsets.only(left: 5.0.wp),
                        // padding: EdgeInsets.only(left: 5.0.wp),
                        color: Colors.red.withOpacity(0.8),
                        alignment: Alignment.centerRight,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 3.0.wp, horizontal: 7.0.wp),
                        child: Row(
                          children: [
                            const SizedBox(
                              height: 20,
                              width: 20,
                              child: Icon(
                                Icons.done,
                                color: blue,
                              ),
                            ),
                            Gap(4.0.wp),
                            Text(
                              element['title'],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(decoration: TextDecoration.lineThrough),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList()
            ],
          )
        : Container());
  }
}
