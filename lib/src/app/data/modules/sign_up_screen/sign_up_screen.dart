import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/src/app/cores/utils/values/images_string.dart';
import 'package:to_do_list/src/app/data/modules/sign_up_screen/sign_up_controller.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final SignUpController controller = Get.put(SignUpController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                        child: SizedBox(
                      height: 40,
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
                            contentPadding:
                                EdgeInsets.only(bottom: 10, left: 15),
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
                            controller.registration(
                                email: emailController.text,
                                password: passwordController.text);
                          },
                          child: const Text("Sign up")),
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
