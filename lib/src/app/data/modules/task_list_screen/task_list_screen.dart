import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/src/app/cores/utils/values/images_string.dart';
import 'package:to_do_list/src/app/data/modules/create_task_screen/create_task_screen.dart';
import 'package:to_do_list/src/app/data/modules/edit_task_screen/edit_task_screen.dart';
import 'package:to_do_list/src/app/data/modules/task_list_screen/task_list_controller.dart';
import 'package:to_do_list/src/app/data/modules/widgets/done_task_widget.dart';
import 'package:to_do_list/src/app/data/modules/widgets/planning_task_widget.dart';

class TaskListScreen extends GetView<TaskListController> {
  TaskListScreen(
      {super.key,
      this.isToday = false,
      this.isYesterday = false,
      this.isTomorrow});
  bool isToday;
  bool? isYesterday;
  bool? isTomorrow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Get.to(() => const CreateTaskScreen());
            controller.fetchTodayTasks();
          },
          backgroundColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: SafeArea(
            child: Obx(() => controller.taskList.isEmpty
                ? Center(
                    child: SizedBox(
                      child: Column(
                        children: [
                          Container(
                              height: 30,
                              decoration:
                                  const BoxDecoration(color: Colors.blue),
                              child: Center(
                                  child: Text(
                                      isToday
                                          ? 'Jadwal Hari ini'
                                          : isYesterday!
                                              ? 'Jadwal Kemaren'
                                              : 'Jadwal Besok',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .merge(const TextStyle(
                                              color: Colors.white))))),
                          Image(image: AssetImage(emptyList)),
                          Text("Belum ada jadwal yang dibuat",
                              style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 30,
                            decoration: const BoxDecoration(color: Colors.blue),
                            child: Center(
                                child: Text(
                                    isToday
                                        ? 'Jadwal Hari ini'
                                        : isYesterday!
                                            ? 'Jadwal Kemaren'
                                            : 'Jadwal Besok',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .merge(const TextStyle(
                                            color: Colors.white))))),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              SizedBox(
                                height: 300,
                                width: double.infinity,
                                child: ListView.builder(
                                  itemCount: controller.taskList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final taskData = controller.taskList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        // Anda dapat menavigasi ke EditTaskScreen dengan membawa data task:
                                        Get.to(() =>
                                            EditTaskScreen(taskData: taskData));
                                      },
                                      child: PlanningTaskWidget(
                                        taskData: taskData,
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
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
                              SizedBox(
                                height: 300,
                                width: double.infinity,
                                child: ListView.builder(
                                  itemCount: controller.doneTaskList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final taskData =
                                        controller.doneTaskList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        // Anda dapat menavigasi ke EditTaskScreen dengan membawa data task:
                                        Get.to(() =>
                                            EditTaskScreen(taskData: taskData));
                                      },
                                      child: DoneTaskWidget(
                                        taskData: taskData,
                                      ),
                                    );
                                  },
                                ),
                              )
                              // const DoneTaskWidget(),
                              // const DoneTaskWidget(),
                              // const DoneTaskWidget(),
                              // const DoneTaskWidget(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))));
  }
}
