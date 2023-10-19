import 'package:get/get.dart';
import 'package:to_do_list/src/app/cores/firebase/firestore/firestore_methods.dart';

class EditTaskController extends GetxController {
  FireStoreMethods fireStoreMethods = FireStoreMethods();

  void updateTask(id, updatedData) async {
    await fireStoreMethods.updateTaskData(id, updatedData);
  }
}
