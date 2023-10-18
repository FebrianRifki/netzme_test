import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:to_do_list/src/app/cores/firebase/firestore/firestore_methods.dart';

class TaskListController extends GetxController {
  final bool isToday;
  final bool? isYesterday;
  final bool? isTomorrow;

  TaskListController({
    required this.isToday,
    this.isYesterday,
    this.isTomorrow,
  });

  @override
  void onInit() {
    fetchTodayTasks();
    fetchTodayDoneTasks();
    super.onInit();
  }

  FireStoreMethods fireStoreMethods = FireStoreMethods();
  RxList taskList = [].obs;
  RxList doneTaskList = [].obs;

  fetchTodayTasks() async {
    var result = await fireStoreMethods.getTodayTasks();
    taskList.assignAll(result);
  }

  fetchTodayDoneTasks() async {
    var result = await fireStoreMethods.getTodayDoneTask();
    doneTaskList.assignAll(result);
  }
}
