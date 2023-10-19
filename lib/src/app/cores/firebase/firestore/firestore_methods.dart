import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:to_do_list/src/app/models/task.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> todayList = [];
  List<Map<String, dynamic>> todayDoneList = [];
  List<Map<String, dynamic>> tomorrowList = [];
  List<Map<String, dynamic>> tomorrowDoneList = [];
  List<Map<String, dynamic>> yesterdayList = [];
  List<Map<String, dynamic>> yesterdayDoneList = [];

  Map<String, dynamic> task = {};

  Future<String> createTask(
      String name, String status, String description) async {
    try {
      String taskId = const Uuid().v1();
      Task task = Task(
          id: taskId, name: name, status: status, description: description);
      await _firestore.collection('tasks').doc(taskId).set(task.toJson());
      return 'success';
    } catch (err) {
      return 'An error occurred: $err';
    }
  }

  Future<List<Map<String, dynamic>>> getTodayTasks() async {
    try {
      var querySnapshot = await _firestore
          .collection('tasks')
          .where('due_date', isEqualTo: 'Hari ini')
          .where('status', isEqualTo: 'On-progress')
          .get();
      todayList.assignAll(querySnapshot.docs.map((doc) => doc.data()));
      return todayList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  getTodayDoneTask() async {
    var querySnapshot = await _firestore
        .collection('tasks')
        .where('due_date', isEqualTo: 'Hari ini')
        .where('status', isEqualTo: 'Done')
        .get();
    todayDoneList.assignAll(querySnapshot.docs.map((doc) => doc.data()));
    return todayDoneList;
  }

  getYesterdayTasks() async {
    var querySnapshot = await _firestore
        .collection('tasks')
        .where('due_date', isEqualTo: 'Kemarin')
        .where('status', isEqualTo: 'On-progress')
        .get();
    yesterdayList.assignAll(querySnapshot.docs.map((doc) => doc.data()));
    return yesterdayList;
  }

  getYesterdayDoneTasks() async {
    var querySnapshot = await _firestore
        .collection('tasks')
        .where('due_date', isEqualTo: 'Kemarin')
        .where('status', isEqualTo: 'Done')
        .get();
    yesterdayDoneList.assignAll(querySnapshot.docs.map((doc) => doc.data()));
    return yesterdayDoneList;
  }

  Future<List<Map<String, dynamic>>> getTomorrowTasks() async {
    try {
      var querySnapshot = await _firestore
          .collection('tasks')
          .where('due_date', isEqualTo: 'Besok')
          .where('status', isEqualTo: 'On-progress')
          .get();
      tomorrowList.assignAll(querySnapshot.docs.map((doc) => doc.data()));
      return tomorrowList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getTomorrowDoneTasks() async {
    try {
      var querySnapshot = await _firestore
          .collection('tasks')
          .where('due_date', isEqualTo: 'Besok')
          .where('status', isEqualTo: 'Done')
          .get();
      tomorrowDoneList.assignAll(querySnapshot.docs.map((doc) => doc.data()));
      return tomorrowDoneList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  updateTaskData(id, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('tasks').doc(id).update(updatedData);
    } catch (e) {
      print('Error occured when updating data');
    }
  }

  deleteTask(id) async {
    try {
      await _firestore.collection('tasks').doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
