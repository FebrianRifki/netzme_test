import 'package:get/get.dart';
import 'package:to_do_list/src/app/cores/firebase/firestore/firestore_methods.dart';

class CreateTaskController extends GetxController {
  FireStoreMethods fireStoreMethods = FireStoreMethods();
  RxBool isEmptyValue = false.obs;
  RxBool isProcessing = false.obs;
  createTask(name, dueDate, description) {
    isProcessing.value = true;
    var res = fireStoreMethods.createTask(name, dueDate, description);
    isProcessing.value = false;
    return res;
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
