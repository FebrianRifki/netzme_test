import 'package:get/get.dart';
import 'package:to_do_list/src/app/cores/firebase/firestore/firestore_methods.dart';

class CreateTaskController extends GetxController {
  FireStoreMethods fireStoreMethods = FireStoreMethods();
  createTask(name, dueDate, description) {
    var res = fireStoreMethods.createTask(name, dueDate, description);
    print(res);
  }
}
