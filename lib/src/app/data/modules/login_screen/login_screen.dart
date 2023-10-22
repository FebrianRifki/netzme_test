import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/src/app/cores/utils/values/images_string.dart';
import 'package:to_do_list/src/app/data/modules/login_screen/login_controller.dart';
import 'package:to_do_list/src/app/data/modules/sign_up_screen/sign_up_screen.dart';
import 'package:to_do_list/src/app/data/modules/tasks_screen/task_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
  final LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage(loginImage),
              height: size.height * 0.5,
            ),
            Column(
              children: [
                Form(
                  key: _emailFormKey,
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        errorText: controller.isErrorEmail.isTrue
                            ? 'Email tidak boleh kosong'
                            : null,
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding:
                            const EdgeInsets.only(bottom: 10, left: 15),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30)))),
                    validator: (value) {
                      return controller.validateEmail(value);
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Form(
                  key: _passwordFormKey,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        errorText: controller.isErrorPassword.isTrue
                            ? 'Password tidak boleh kosong'
                            : null,
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding:
                            const EdgeInsets.only(bottom: 10, left: 15),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30)))),
                    validator: (value) {
                      return controller.validatePassword(value);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white),
                      onPressed: () async {
                        if (controller.isProcessing.isTrue) {
                        } else if (_emailFormKey.currentState!.validate() &&
                            _passwordFormKey.currentState!.validate()) {
                          await controller.signin(
                              email: emailController.text,
                              password: passwordController.text);
                        }
                      },
                      child: Obx(
                        () => controller.isProcessing.isTrue
                            ? const SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text("Sign in"),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Dont have an accout? '),
                    GestureDetector(
                      onTap: () => Get.to(const SingUpScreen()),
                      child: const Text(
                        'Sing up',
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                    )
                  ],
                )
              ],
            ),
            Obx(() {
              if (controller.isSuccessLogin.isTrue) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Get.snackbar(
                    'Success',
                    'Login Successfully!',
                    colorText: Colors.white,
                    duration: const Duration(seconds: 1),
                    backgroundColor: Colors.blue,
                  );
                });
              }
              return const SizedBox.shrink();
            }),
            Obx(() {
              if (controller.isWrongCredential.isTrue) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Get.snackbar(
                    'Gagal',
                    controller.errorMessage.value,
                    duration: const Duration(seconds: 1),
                    backgroundColor: Colors.redAccent,
                  );
                });
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    ));
  }
}
