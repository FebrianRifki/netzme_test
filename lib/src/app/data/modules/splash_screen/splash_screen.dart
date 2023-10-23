import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/src/app/cores/firebase/firestore/firestore_methods.dart';
import 'package:to_do_list/src/app/cores/utils/values/images_string.dart';
import 'package:to_do_list/src/app/data/modules/splash_screen/splash_screen_controller.dart';
import 'package:flutter/animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashScreenController controller = Get.put(SplashScreenController());

  @override
  void initState() {
    controller.animationStart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Stack(
          children: [
            Obx(
              () => AnimatedPositioned(
                  duration: const Duration(milliseconds: 2500),
                  top: 50,
                  left: controller.isAnimated.value ? 50 : -50,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      'Todo App',
                      style: Theme.of(context).textTheme.displayMedium!.merge(
                          const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  )),
            ),
            Obx(
              () => AnimatedPositioned(
                duration: const Duration(milliseconds: 2500),
                top: controller.isAnimated.value ? 170 : 120,
                left: 50,
                child: CircleAvatar(
                  radius: 150,
                  backgroundImage: AssetImage(imageSplash),
                ),
              ),
            ),
            Obx(
              () => AnimatedPositioned(
                  duration: const Duration(milliseconds: 2500),
                  bottom: 100,
                  right: controller.isAnimated.value ? 40 : -40,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      'Buat jadwal sekarang',
                      style: Theme.of(context).textTheme.headlineLarge!.merge(
                          const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  )),
            )
            // Image(image: AssetImage(imageSplash))
          ],
        ));
  }
}
