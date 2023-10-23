import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/src/app/cores/firebase/firestore/firestore_methods.dart';
import 'package:to_do_list/src/app/data/modules/login_screen/login_screen.dart';
import 'package:to_do_list/src/app/data/modules/tasks_screen/task_screen.dart';

class SplashScreenController extends GetxController {
  RxBool isAnimated = false.obs;
  final FireStoreMethods _fireStoreMethods = FireStoreMethods();
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  void animationStart() async {
    await Future.delayed(const Duration(milliseconds: 500));
    isAnimated.value = true;
    await Future.delayed(const Duration(milliseconds: 3000));
    await handleDataStatus();
    await checkUser();
  }

  handleDataStatus() async {
    await _fireStoreMethods.handleDataStatus();
  }

  checkUser() async {
    SharedPreferences pref = await _pref;
    String? currentEmail = pref.getString('email');

    if (currentEmail != null) {
      Get.to(() => const TaskScreen());
    } else {
      Get.to(() => const LoginScreen());
    }
  }
}
