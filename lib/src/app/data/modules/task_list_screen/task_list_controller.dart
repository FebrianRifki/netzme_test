import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:to_do_list/src/app/cores/firebase/firestore/firestore_methods.dart';
import 'package:to_do_list/src/app/data/modules/widgets/planning_task_widget.dart';

class TaskListController extends GetxController {
  @override
  void onInit() {
    fetchAllData();
    super.onInit();
  }

  FireStoreMethods fireStoreMethods = FireStoreMethods();
  RxList taskList = [].obs;
  RxList doneTaskList = [].obs;
  RxList tomorrowTaskList = [].obs;
  RxList tomorrowDoneTaskList = [].obs;
  RxList yesterdayTaskList = [].obs;
  RxList yesterdayDoneTaskList = [].obs;
  final deleting = false.obs;
  final dragId = "".obs;
  RxBool isProcessing = false.obs;

  fetchTodayTasks() async {
    var result = await fireStoreMethods.getTodayTasks();
    taskList.assignAll(result);
  }

  fetchTodayDoneTasks() async {
    var result = await fireStoreMethods.getTodayDoneTask();
    doneTaskList.assignAll(result);
  }

  fetchTomorrowTask() async {
    var result = await fireStoreMethods.getTomorrowTasks();
    tomorrowTaskList.assignAll(result);
  }

  fetchTomorrowDoneTask() async {
    var result = await fireStoreMethods.getTomorrowDoneTasks();
    tomorrowDoneTaskList.assignAll(result);
  }

  fetchYesterdayTask() async {
    var result = await fireStoreMethods.getYesterdayTasks();
    yesterdayTaskList.assignAll(result);
  }

  fetchYesterdayDoneTask() async {
    var result = await fireStoreMethods.getYesterdayDoneTasks();
    yesterdayDoneTaskList.assignAll(result);
  }

  void updateTask(id, updatedData) async {
    await fireStoreMethods.updateTaskData(id, updatedData);
    fetchAllData();
  }

  deleteTask(id) async {
    await fireStoreMethods.deleteTask(id);
    deleting.value = false;
    fetchAllData();
  }

  void changeDeleting(bool value, String id) {
    deleting.value = value;
    dragId.value = id;
  }

  fetchAllData() async {
    await fetchTodayTasks();
    await fetchTodayDoneTasks();
    await fetchTomorrowTask();
    await fetchTodayDoneTasks();
    await fetchYesterdayTask();
    await fetchYesterdayDoneTask();
  }
}
