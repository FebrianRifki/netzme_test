import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/src/app/models/task.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
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
      final SharedPreferences prefs = await _prefs;
      String taskId = const Uuid().v1();
      String? email = prefs.getString('email');
      Task task = Task(
          email: email!,
          id: taskId,
          name: name,
          status: status,
          description: description);
      await _firestore.collection('tasks').doc(taskId).set(task.toJson());
      return 'success';
    } catch (err) {
      return 'An error occurred: $err';
    }
  }

  Future<List<Map<String, dynamic>>> getTodayTasks(email) async {
    try {
      var querySnapshot = await _firestore
          .collection('tasks')
          .where('due_date', isEqualTo: 'Hari ini')
          .where('status', isEqualTo: 'On-progress')
          .where('email', isEqualTo: email)
          .get();
      todayList.assignAll(querySnapshot.docs.map((doc) => doc.data()));
      return todayList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  getTodayDoneTask(email) async {
    var querySnapshot = await _firestore
        .collection('tasks')
        .where('due_date', isEqualTo: 'Hari ini')
        .where('status', isEqualTo: 'Done')
        .where('email', isEqualTo: email)
        .get();
    todayDoneList.assignAll(querySnapshot.docs.map((doc) => doc.data()));
    return todayDoneList;
  }

  getYesterdayTasks(email) async {
    var querySnapshot = await _firestore
        .collection('tasks')
        .where('due_date', isEqualTo: 'Kemarin')
        .where('status', isEqualTo: 'On-progress')
        .where('email', isEqualTo: email)
        .get();
    yesterdayList.assignAll(querySnapshot.docs.map((doc) => doc.data()));
    return yesterdayList;
  }

  getYesterdayDoneTasks(email) async {
    var querySnapshot = await _firestore
        .collection('tasks')
        .where('due_date', isEqualTo: 'Kemarin')
        .where('status', isEqualTo: 'Done')
        .where('email', isEqualTo: email)
        .get();
    yesterdayDoneList.assignAll(querySnapshot.docs.map((doc) => doc.data()));
    return yesterdayDoneList;
  }

  Future<List<Map<String, dynamic>>> getTomorrowTasks(email) async {
    try {
      var querySnapshot = await _firestore
          .collection('tasks')
          .where('due_date', isEqualTo: 'Besok')
          .where('status', isEqualTo: 'On-progress')
          .where('email', isEqualTo: email)
          .get();
      tomorrowList.assignAll(querySnapshot.docs.map((doc) => doc.data()));
      return tomorrowList;
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

  handleDataStatus() async {
    try {
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

      Timestamp todayTimestamp = Timestamp.fromDate(today);
      Timestamp yesterdayTimestamp = Timestamp.fromDate(yesterday); // value 22

      // delete expired tasks
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('tasks')
          .where('created_at',
              isLessThan:
                  yesterdayTimestamp) // 22 == 22 , yang dihapus tanggal 21
          .where('due_date', isEqualTo: 'Kemarin')
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc
          in querySnapshot.docs) {
        await doc.reference.delete();
      }

      // update yesterday status tasks
      QuerySnapshot<Map<String, dynamic>> queryTodaySnapshot = await _firestore
          .collection('tasks')
          .where('created_at', isLessThan: todayTimestamp)
          .where('due_date', isEqualTo: 'Hari ini')
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc
          in queryTodaySnapshot.docs) {
        String docId = doc.id;

        await _firestore
            .collection('tasks')
            .doc(docId)
            .update({'due_date': 'Kemarin'});
      }

      // update today status tasks
      QuerySnapshot<Map<String, dynamic>> queryTomorrowSnapshot =
          await _firestore
              .collection('tasks')
              .where('created_at', isLessThanOrEqualTo: todayTimestamp)
              .where('due_date', isEqualTo: 'Besok')
              .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc
          in queryTomorrowSnapshot.docs) {
        String docId = doc.id;

        await _firestore
            .collection('tasks')
            .doc(docId)
            .update({'due_date': 'Hari ini'});
      }
    } catch (err) {
      return err.toString();
    }
  }
}
