import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/src/app/cores/firebase/firebase_auth/auth_method.dart';
import 'package:to_do_list/src/app/data/modules/tasks_screen/task_screen.dart';

class LoginController extends GetxController {
  RxBool isProcessing = false.obs;
  RxBool isErrorEmail = false.obs;
  RxBool isErrorPassword = false.obs;
  RxBool isSuccessLogin = false.obs;
  RxBool isWrongCredential = false.obs;
  RxString errorMessage = ''.obs;

  AuthMethod authMethod = AuthMethod();
  signin({required email, required password}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isProcessing.value = true;
    String res = await authMethod.loginUser(email: email, password: password);
    if (res == "success") {
      prefs.setString('email', email);
      isSuccessLogin.value = true;
      Get.delete<LoginController>();
      await Future.delayed(const Duration(milliseconds: 1600), () {
        Get.offAll(() => const TaskScreen());
      });
    } else {
      errorMessage.value = 'Wrong username or password';
      isSuccessLogin.value = false;
      isWrongCredential.value = true;
      await Future.delayed(const Duration(milliseconds: 1000));
      isWrongCredential.value = false;
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

  signout() async {
    isProcessing.value = true;
    await authMethod.singOut();
    isProcessing.value = false;
    return "success";
  }
}
