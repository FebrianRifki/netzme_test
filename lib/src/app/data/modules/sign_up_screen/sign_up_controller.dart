import 'package:get/get.dart';
import 'package:to_do_list/src/app/cores/firebase/firebase_auth/auth_method.dart';

class SignUpController extends GetxController {
  AuthMethod authMethod = AuthMethod();

  registration({required String email, required String password}) async {
    try {
      String res =
          await authMethod.singUpUser(email: email, password: password);
      print(res);
    } catch (e) {
      print(e);
    }
  }
}
