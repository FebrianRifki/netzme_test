import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/src/app/cores/firebase/firebase_auth/auth_method.dart';
import 'package:to_do_list/src/app/cores/firebase/firestore/firestore_methods.dart';
import 'package:to_do_list/src/app/data/modules/login_screen/login_screen.dart';

class TaskListController extends GetxController {
  FireStoreMethods fireStoreMethods = FireStoreMethods();
  AuthMethod authMethod = AuthMethod();
  RxList taskList = [].obs;
  RxList doneTaskList = [].obs;
  RxList tomorrowTaskList = [].obs;
  RxList tomorrowDoneTaskList = [].obs;
  RxList yesterdayTaskList = [].obs;
  RxList yesterdayDoneTaskList = [].obs;
  final deleting = false.obs;
  final dragId = "".obs;
  RxBool isProcessing = false.obs;
  RxBool isEmptyTodayTask = false.obs;
  RxBool isEmptyYesterdayTask = false.obs;
  String? email;
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  @override
  void onInit() async {
    SharedPreferences pref = await _pref;
    email = pref.getString('email');
    fetchAllData();
    super.onInit();
  }

  fetchTodayTasks(email) async {
    var result = await fireStoreMethods.getTodayTasks(email);
    taskList.assignAll(result);
  }

  fetchTodayDoneTasks(email) async {
    var result = await fireStoreMethods.getTodayDoneTask(email);
    doneTaskList.assignAll(result);
  }

  fetchTomorrowTask(email) async {
    var result = await fireStoreMethods.getTomorrowTasks(email);
    tomorrowTaskList.assignAll(result);
  }

  fetchYesterdayTask(email) async {
    var result = await fireStoreMethods.getYesterdayTasks(email);
    yesterdayTaskList.assignAll(result);
  }

  fetchYesterdayDoneTask(email) async {
    var result = await fireStoreMethods.getYesterdayDoneTasks(email);
    yesterdayDoneTaskList.assignAll(result);
  }

  void updateTask(id, updatedData) async {
    await fireStoreMethods.updateTaskData(id, updatedData);
    fetchWithOutProcessing();
  }

  deleteTask(id) async {
    await fireStoreMethods.deleteTask(id);
    deleting.value = false;
    fetchWithOutProcessing();
  }

  void changeDeleting(bool value, String id) {
    deleting.value = value;
    dragId.value = id;
  }

  void logout() async {
    await authMethod.singOut();
    SharedPreferences pref = await _pref;
    pref.remove('email');
    Get.offAll(() => const LoginScreen());
  }

  fetchAllData() async {
    isProcessing.value = true;
    await fetchTodayTasks(email);
    await fetchTodayDoneTasks(email);
    await fetchTomorrowTask(email);
    await fetchTodayDoneTasks(email);
    await fetchYesterdayTask(email);
    await fetchYesterdayDoneTask(email);
    isProcessing.value = false;
    if (taskList.isEmpty && doneTaskList.isEmpty) {
      isEmptyTodayTask.value = true;
    }
    if (yesterdayTaskList.isEmpty && yesterdayDoneTaskList.isEmpty) {
      isEmptyYesterdayTask.value = true;
    }
  }

  fetchWithOutProcessing() async {
    await fetchTodayTasks(email);
    await fetchTodayDoneTasks(email);
    await fetchTomorrowTask(email);
    await fetchTodayDoneTasks(email);
    await fetchYesterdayTask(email);
    await fetchYesterdayDoneTask(email);
    if (taskList.isEmpty && doneTaskList.isEmpty) {
      isEmptyTodayTask.value = true;
    } else if (yesterdayTaskList.isEmpty && yesterdayDoneTaskList.isEmpty) {
      isEmptyYesterdayTask.value = true;
    }
  }
}
