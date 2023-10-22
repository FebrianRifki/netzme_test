import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/src/app/cores/utils/values/images_string.dart';
import 'package:to_do_list/src/app/data/modules/login_screen/login_screen.dart';
import 'package:to_do_list/src/app/data/modules/sign_up_screen/sign_up_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController controller = Get.put(SignUpController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(
                  image: AssetImage(singUpImage),
                  height: size.height * 0.5,
                ),
                Column(
                  children: [
                    Form(
                        key: _emailFormKey,
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.grey),
                              contentPadding:
                                  EdgeInsets.only(bottom: 10, left: 15),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)))),
                          validator: (value) {
                            return controller.validateEmail(value);
                          },
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Form(
                        key: _passwordFormKey,
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.grey),
                              contentPadding:
                                  EdgeInsets.only(bottom: 10, left: 15),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)))),
                          validator: (value) {
                            return controller.validatePassword(value);
                          },
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
                          onPressed: () async {
                            if (controller.isProcessing.isTrue) {
                            } else if (_emailFormKey.currentState!.validate() &&
                                _passwordFormKey.currentState!.validate()) {
                              var result = await controller.registration(
                                  email: emailController.text,
                                  password: passwordController.text);
                              if (result == "user created") {
                                Get.snackbar(
                                  'Success',
                                  'Registrasi berhasil!',
                                  colorText: Colors.white,
                                  duration: const Duration(seconds: 1),
                                  backgroundColor: Colors.blue,
                                );
                                Get.to(() => const LoginScreen());
                              } else {
                                Get.snackbar(
                                  'Gagal',
                                  'email sudah dipakai',
                                  duration: const Duration(seconds: 1),
                                  backgroundColor: Colors.redAccent,
                                );
                              }
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
                                : const Text("Daftar"),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
