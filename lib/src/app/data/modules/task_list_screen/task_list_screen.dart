import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/src/app/cores/utils/values/images_string.dart';
import 'package:to_do_list/src/app/data/modules/create_task_screen/create_task_screen.dart';
import 'package:to_do_list/src/app/data/modules/detail_screen/detail_screen.dart';
import 'package:to_do_list/src/app/data/modules/edit_task_screen/edit_task_screen.dart';
import 'package:to_do_list/src/app/data/modules/task_list_screen/task_list_controller.dart';
import 'package:to_do_list/src/app/data/modules/widgets/done_task_widget.dart';
import 'package:to_do_list/src/app/data/modules/widgets/planning_task_widget.dart';

class TaskListScreen extends GetView<TaskListController> {
  TaskListScreen(
      {super.key,
      this.isToday = false,
      this.isYesterday = false,
      this.isTomorrow = false});
  bool isToday;
  bool? isYesterday;
  bool? isTomorrow;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: DragTarget(
          builder: (_, __, ___) {
            return Obx(
              () => Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: FloatingActionButton(
                  onPressed: () async {
                    await Get.to(() => const CreateTaskScreen());
                    await controller.fetchWithOutProcessing();
                  },
                  backgroundColor:
                      controller.deleting.isTrue ? Colors.red : Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Icon(
                    controller.deleting.isTrue ? Icons.delete : Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
          onAccept: (taskData) {
            controller.deleteTask(controller.dragId.value);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SafeArea(
            child: Obx(() => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 50,
                          decoration: const BoxDecoration(color: Colors.blue),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    isToday
                                        ? 'Jadwal Hari ini'
                                        : isYesterday!
                                            ? 'Jadwal Kemaren'
                                            : 'Jadwal Besok',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .merge(const TextStyle(
                                            color: Colors.white))),
                                GestureDetector(
                                  onTap: () async {
                                    controller.logout();
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((timeStamp) {
                                      Get.snackbar(
                                        'Berhasil',
                                        'Anda telah logout',
                                        colorText: Colors.white,
                                        duration: const Duration(seconds: 1),
                                        backgroundColor: Colors.blue,
                                      );
                                    });
                                  },
                                  child: Text('Logout',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .merge(const TextStyle(
                                              color: Colors.white))),
                                ),
                              ],
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: controller.isProcessing.isTrue
                            ? const LinearProgressIndicator(
                                color: Colors.blue,
                              )
                            : isToday && controller.isEmptyTodayTask.isTrue
                                ? Column(
                                    children: [
                                      Image(image: AssetImage(emptyList)),
                                      Text("Belum ada jadwal yang dibuat",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                    ],
                                  )
                                : isYesterday! &&
                                        controller.isEmptyYesterdayTask.isTrue
                                    ? Column(
                                        children: [
                                          Image(image: AssetImage(emptyList)),
                                          Text("Tidak ada jadwal kemaren",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge),
                                        ],
                                      )
                                    : isTomorrow! &&
                                            controller.tomorrowTaskList.isEmpty
                                        ? Column(
                                            children: [
                                              Image(
                                                  image: AssetImage(emptyList)),
                                              Text("Belum ada untuk besok",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Rencana:',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: isToday
                                                        ? Colors.lightBlue
                                                        : (isYesterday!
                                                            ? Colors.red
                                                            : Colors.blue)),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: isToday
                                                    ? controller.taskList.length
                                                    : isTomorrow!
                                                        ? controller
                                                            .tomorrowTaskList
                                                            .length
                                                        : controller
                                                            .yesterdayTaskList
                                                            .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  final taskData = isToday
                                                      ? controller
                                                          .taskList[index]
                                                      : isTomorrow!
                                                          ? controller
                                                                  .tomorrowTaskList[
                                                              index]
                                                          : controller
                                                                  .yesterdayTaskList[
                                                              index];
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      await Get.to(() =>
                                                          DetailScreen(
                                                            taskData: taskData,
                                                          ));
                                                      controller
                                                          .fetchWithOutProcessing();
                                                    },
                                                    child: LongPressDraggable(
                                                      data: taskData,
                                                      onDragStarted: () =>
                                                          controller
                                                              .changeDeleting(
                                                                  true,
                                                                  taskData[
                                                                      "id"]),
                                                      onDraggableCanceled:
                                                          (_, __) => controller
                                                              .changeDeleting(
                                                                  false,
                                                                  taskData[
                                                                      "id"]),
                                                      feedback: Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: SizedBox(
                                                          width: size.width * 1,
                                                          child: Opacity(
                                                            opacity: 0.8,
                                                            child: isToday
                                                                ? PlanningTaskWidget(
                                                                    taskData:
                                                                        taskData,
                                                                    isToday:
                                                                        true,
                                                                    onPressedCallBack:
                                                                        () {})
                                                                : isTomorrow!
                                                                    ? PlanningTaskWidget(
                                                                        taskData:
                                                                            taskData,
                                                                        isTomorrow:
                                                                            true,
                                                                        onPressedCallBack:
                                                                            () {})
                                                                    : PlanningTaskWidget(
                                                                        taskData:
                                                                            taskData,
                                                                        onPressedCallBack:
                                                                            () {}),
                                                          ),
                                                        ),
                                                      ),
                                                      child: isToday
                                                          ? PlanningTaskWidget(
                                                              taskData:
                                                                  taskData,
                                                              isToday: true,
                                                              onPressedCallBack:
                                                                  () {
                                                                Map<String,
                                                                        dynamic>
                                                                    updatedData =
                                                                    {
                                                                  'status':
                                                                      'Done'
                                                                };
                                                                controller.updateTask(
                                                                    taskData[
                                                                        'id'],
                                                                    updatedData);
                                                              },
                                                            )
                                                          : isYesterday! &&
                                                                  controller
                                                                      .isEmptyYesterdayTask
                                                                      .isFalse
                                                              ? PlanningTaskWidget(
                                                                  taskData:
                                                                      taskData,
                                                                  onPressedCallBack:
                                                                      () {
                                                                    Map<String,
                                                                            dynamic>
                                                                        updatedData =
                                                                        {
                                                                      'status':
                                                                          'On-progress',
                                                                      'due_date':
                                                                          'Hari ini'
                                                                    };
                                                                    controller.updateTask(
                                                                        taskData[
                                                                            'id'],
                                                                        updatedData);
                                                                  })
                                                              : PlanningTaskWidget(
                                                                  taskData:
                                                                      taskData,
                                                                  isTomorrow:
                                                                      true,
                                                                  onPressedCallBack:
                                                                      () {
                                                                    Map<String,
                                                                            dynamic>
                                                                        updatedData =
                                                                        {
                                                                      'status':
                                                                          'On-progress',
                                                                      'due_date':
                                                                          'Hari ini'
                                                                    };
                                                                    controller.updateTask(
                                                                        taskData[
                                                                            'id'],
                                                                        updatedData);
                                                                  }),
                                                    ),
                                                  );
                                                },
                                              )
                                            ],
                                          ),
                      ),
                      isToday &&
                              controller.isEmptyTodayTask.isFalse &&
                              controller.isProcessing.isFalse
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Selesai:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isToday
                                            ? Colors.lightBlue
                                            : (isYesterday!
                                                ? Colors.red
                                                : Colors.blue)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: isToday
                                        ? controller.doneTaskList.length
                                        : isTomorrow!
                                            ? controller
                                                .tomorrowDoneTaskList.length
                                            : controller
                                                .yesterdayDoneTaskList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final taskData = isToday
                                          ? controller.doneTaskList[index]
                                          : isTomorrow!
                                              ? controller
                                                  .tomorrowDoneTaskList[index]
                                              : controller
                                                  .yesterdayDoneTaskList[index];
                                      return GestureDetector(
                                        onTap: () {
                                          // Get.to(() =>
                                          //     EditTaskScreen(taskData: taskData));
                                        },
                                        child: isToday
                                            ? DoneTaskWidget(
                                                taskData: taskData,
                                                isToday: true,
                                                onPressedCallBack: () {
                                                  Map<String, dynamic>
                                                      updatedData = {
                                                    'status': 'On-progress'
                                                  };
                                                  controller.updateTask(
                                                      taskData['id'],
                                                      updatedData);
                                                },
                                              )
                                            : isTomorrow!
                                                ? DoneTaskWidget(
                                                    taskData: taskData,
                                                    isTomorrow: true,
                                                    onPressedCallBack: () {},
                                                  )
                                                : DoneTaskWidget(
                                                    taskData: taskData,
                                                    onPressedCallBack: () {},
                                                  ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            )
                          : isYesterday! &&
                                  controller.isEmptyYesterdayTask.isFalse
                              ? Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Selesai:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isToday
                                                ? Colors.lightBlue
                                                : (isYesterday!
                                                    ? Colors.red
                                                    : Colors.blue)),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: isToday
                                            ? controller.doneTaskList.length
                                            : isTomorrow!
                                                ? controller
                                                    .tomorrowDoneTaskList.length
                                                : controller
                                                    .yesterdayDoneTaskList
                                                    .length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final taskData = isToday
                                              ? controller.doneTaskList[index]
                                              : isTomorrow!
                                                  ? controller
                                                          .tomorrowDoneTaskList[
                                                      index]
                                                  : controller
                                                          .yesterdayDoneTaskList[
                                                      index];
                                          return GestureDetector(
                                            onTap: () {},
                                            child: isToday
                                                ? DoneTaskWidget(
                                                    taskData: taskData,
                                                    isToday: true,
                                                    onPressedCallBack: () {
                                                      Map<String, dynamic>
                                                          updatedData = {
                                                        'status': 'On-progress'
                                                      };
                                                      controller.updateTask(
                                                          taskData['id'],
                                                          updatedData);
                                                    },
                                                  )
                                                : isTomorrow!
                                                    ? DoneTaskWidget(
                                                        taskData: taskData,
                                                        isTomorrow: true,
                                                        onPressedCallBack:
                                                            () {},
                                                      )
                                                    : DoneTaskWidget(
                                                        taskData: taskData,
                                                        onPressedCallBack:
                                                            () {},
                                                      ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                )
                              : Container(),
                    ],
                  ),
                ))));
  }
}
