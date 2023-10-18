import 'package:get/get.dart';
import 'package:to_do_list/src/app/cores/firebase/firebase_auth/auth_method.dart';
import 'package:to_do_list/src/app/data/modules/tasks_screen/task_screen.dart';

class LoginController extends GetxController {
  RxBool isProcessing = false.obs;
  AuthMethod authMethod = AuthMethod();
  signin({required email, required password}) async {
    isProcessing.value = true;
    String res = await authMethod.loginUser(email: email, password: password);
    print(res);
    isProcessing.value = false;
    Get.to(() => const TaskScreen());
  }

  signout() async {
    isProcessing.value = true;
    await authMethod.singOut();
    isProcessing.value = false;
    return "success";
  }
}
