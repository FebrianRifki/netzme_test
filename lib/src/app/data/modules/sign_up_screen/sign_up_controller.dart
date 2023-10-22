import 'package:get/get.dart';
import 'package:to_do_list/src/app/cores/firebase/firebase_auth/auth_method.dart';
import 'package:to_do_list/src/app/data/modules/login_screen/login_screen.dart';

class SignUpController extends GetxController {
  AuthMethod authMethod = AuthMethod();
  RxBool isErrorEmail = false.obs;
  RxBool isErrorPassword = false.obs;
  RxBool isSuccessRegister = false.obs;
  RxBool isFailedRegister = false.obs;
  RxBool isProcessing = false.obs;

  registration({required String email, required String password}) async {
    try {
      isProcessing.value = true;
      isFailedRegister.value = false;
      isSuccessRegister.value = false;
      String res =
          await authMethod.singUpUser(email: email, password: password);
      if (res == 'user created') {
        isSuccessRegister.value = true;
        Get.delete<SignUpController>();
        Future.delayed(const Duration(milliseconds: 1600));
        isProcessing.value = false;
        return res;
      } else {
        isFailedRegister.value = true;
      }
      isProcessing.value = false;
    } catch (e) {
      print(e);
    }
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
}
