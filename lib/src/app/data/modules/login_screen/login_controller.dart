import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/src/app/cores/firebase/firebase_auth/auth_method.dart';
import 'package:to_do_list/src/app/data/modules/sign_up_screen/sign_up_screen.dart';
import 'package:to_do_list/src/app/data/modules/task_list_screen/task_list_controller.dart';
import 'package:to_do_list/src/app/data/modules/tasks_screen/task_screen.dart';

class LoginController extends GetxController {
  RxBool isProcessing = false.obs;
  RxBool isErrorEmail = false.obs;
  RxBool isErrorPassword = false.obs;
  RxString errorMessage = ''.obs;

  AuthMethod authMethod = AuthMethod();
  signin({required email, required password}) async {
    isProcessing.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String res = await authMethod.loginUser(email: email, password: password);
    if (res == "success") {
      prefs.setString('email', email);
      Get.delete<LoginController>();
      isProcessing.value = false;
      return res;
    } else {
      errorMessage.value = 'username atau password salah';
    }
    isProcessing.value = false;
  }

  validateEmail(email) {
    if (email.isEmpty) {
      isErrorEmail.value = true;
      return 'Email tidak boleh kosong';
    } else {
      isErrorEmail.value = false;
      return null;
    }
  }

  validatePassword(password) {
    if (password.isEmpty) {
      isErrorPassword.value = true;
      return 'Password tidak boleh kosong';
    } else {
      isErrorPassword.value = false;
      return null;
    }
  }

  gotToSingUpScreen() {
    Get.delete<LoginController>();
    Get.to(() => const SignUpScreen());
  }
}
