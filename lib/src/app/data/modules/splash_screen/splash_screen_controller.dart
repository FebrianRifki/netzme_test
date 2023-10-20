import 'package:get/get.dart';
import 'package:to_do_list/src/app/data/modules/login_screen/login_screen.dart';

class SplashScreenController extends GetxController {
  RxBool isAnimated = false.obs;

  void animationStart() async {
    await Future.delayed(const Duration(milliseconds: 500));
    isAnimated.value = true;
    await Future.delayed(const Duration(milliseconds: 3000));
    Get.to(LoginScreen());
    // isAnimated.value = false;
    // await Future.delayed(const Duration(milliseconds: 2000));
  }
}
