import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:to_do_list/src/app/models/task.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> todayList = [];
  List<Map<String, dynamic>> todayDoneList = [];

  Future<String> createTask(
      String name, String status, String description) async {
    try {
      String taskId = const Uuid().v1();
      Task task = Task(name: name, status: status, description: description);
      await _firestore.collection('tasks').doc(taskId).set(task.toJson());
      return 'success';
    } catch (err) {
      return 'An error occurred: $err';
    }
  }

  getTodayTasks() async {
    var querySnapshot = await _firestore
        .collection('tasks')
        .where('dueDate', isEqualTo: 'Hari ini')
        .get();

    todayList.assignAll(querySnapshot.docs.map((doc) => doc.data()));

    return todayList;
  }

  getTodayDoneTask() async {
    var querySnapshot = await _firestore
        .collection('tasks')
        .where('dueDate', isEqualTo: 'Hari ini')
        .where('status', isEqualTo: 'Done')
        .get();
    todayDoneList.assignAll(querySnapshot.docs.map((doc) => doc.data()));
    return todayDoneList;
  }

  getYesterdayTasks() async {}
  getTomorrowTasks() async {}
}
