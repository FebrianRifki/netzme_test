import 'package:get/get.dart';
import 'package:to_do_list/src/app/data/modules/login_screen/login_controller.dart';
import 'package:to_do_list/src/app/data/modules/sign_up_screen/sign_up_controller.dart';

class ControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => SignUpController());
  }
}
