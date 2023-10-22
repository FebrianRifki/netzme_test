import 'package:get/get.dart';
import 'package:to_do_list/src/app/cores/firebase/firestore/firestore_methods.dart';

class EditTaskController extends GetxController {
  FireStoreMethods fireStoreMethods = FireStoreMethods();
  RxBool isEmptyValue = false.obs;
  RxBool isProcessing = false.obs;

  void updateTask(id, updatedData) async {
    isProcessing.value = true;
    await fireStoreMethods.updateTaskData(id, updatedData);
    isProcessing.value = false;
  }

  validateTaskName(value) {
    if (value.isEmpty) {
      isEmptyValue.value = true;
      return 'nama jadwal tidak boleh kosong';
    } else {
      isEmptyValue.value = false;
      return null;
    }
  }
}
