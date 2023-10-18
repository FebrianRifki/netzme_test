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
                    child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.only(bottom: 10, left: 15),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30)))),
                  ),
                )),
                const SizedBox(
                  height: 15,
                ),
                Form(
                    child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.only(bottom: 10, left: 15),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30)))),
                  ),
                )),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        controller.signin(
                            email: emailController.text,
                            password: passwordController.text);
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
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //           backgroundColor: Colors.blue,
                //           foregroundColor: Colors.white),
                //       onPressed: () async {
                //         var res = await controller.signout();
                //         print(res);
                //       },
                //       child: Obx(
                //         () => controller.isProcessing.isTrue
                //             ? const SizedBox(
                //                 height: 50,
                //                 width: 50,
                //                 child: CircularProgressIndicator(),
                //               )
                //             : const Text("Sign out"),
                //       )),
                // ),
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
          ],
        ),
      ),
    ));
  }
}
