import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/src/app/data/modules/create_task_screen/create_task_controller.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController nameTaskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _taskNameFormKey = GlobalKey<FormState>();
  final CreateTaskController controller = Get.put(CreateTaskController());

  List<String> list = <String>['Hari ini', 'Besok'];
  String dropdownValue = 'Hari ini';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
                height: 30,
                decoration: const BoxDecoration(color: Colors.blue),
                child: Center(
                    child: Text('Tambah Jadwal',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .merge(const TextStyle(color: Colors.white))))),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Form(
                          key: _taskNameFormKey,
                          child: TextFormField(
                            controller: nameTaskController,
                            decoration: const InputDecoration(
                                label: Text('Nama Jadwal'),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            validator: (value) {
                              return controller.validateTaskName(value);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: DropdownMenu<String>(
                            initialSelection: list.first,
                            onSelected: (String? value) {
                              // Call setState() to update the state of the widget
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            dropdownMenuEntries: list
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                value: value,
                                label: value,
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: size.height * 0.3,
                          child: TextField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Deskripsi',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            maxLines: null,
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        if (controller.isProcessing.isTrue) {
                        } else if (_taskNameFormKey.currentState!.validate()) {
                          var result = await controller.createTask(
                              nameTaskController.text,
                              dropdownValue,
                              descriptionController.text);
                          if (result == 'success') {
                            Get.snackbar(
                              'Success',
                              'Jadwal berhasil dibuat',
                              colorText: Colors.white,
                              duration: const Duration(seconds: 1),
                              backgroundColor: Colors.blue,
                            );
                          } else {
                            Get.snackbar(
                              'Gagal',
                              "Oops! something went wrong",
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
                            : const Text("Buat Jadwal"),
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: 10), // Menambahkan jarak horizontal antara tombol.
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
