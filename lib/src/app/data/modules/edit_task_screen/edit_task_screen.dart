import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/src/app/data/modules/edit_task_screen/edit_task_controller.dart';
import 'package:to_do_list/src/app/data/modules/task_list_screen/task_list_controller.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key, required this.taskData});
  final Map<String, dynamic> taskData;
  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  List<String> list = <String>['Hari ini', 'Kemarin', 'Besok'];
  String dropdownValue = 'Hari ini';
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _taskNameFormKey = GlobalKey<FormState>();
  final EditTaskController controller = Get.put(EditTaskController());

  @override
  void initState() {
    taskNameController.text = widget.taskData['name'];
    descriptionController.text = widget.taskData['description'];
    super.initState();
  }

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
                    child: Text('Edit Jadwal',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .merge(const TextStyle(color: Colors.white))))),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
                    child: Column(
                      children: [
                        Form(
                          key: _taskNameFormKey,
                          child: TextFormField(
                            controller: taskNameController,
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
                            initialSelection: widget.taskData["due_date"],
                            onSelected: (String? value) {
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
                          height: size.height * 0.5,
                          child: TextFormField(
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
                    )),
              ),
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
                      onPressed: () {
                        if (controller.isProcessing.isTrue) {
                        } else if (_taskNameFormKey.currentState!.validate()) {
                          var updatedData = {
                            'name': taskNameController.text,
                            'due_date': dropdownValue,
                            'description': descriptionController.text
                          };
                          controller.updateTask(
                              widget.taskData['id'], updatedData);
                          widget.taskData['name'] = taskNameController.text;
                          widget.taskData['due_date'] = dropdownValue;
                          widget.taskData['description'] =
                              descriptionController.text;
                          Get.snackbar(
                            'Success',
                            'Edit data berhasil',
                            colorText: Colors.white,
                            duration: const Duration(seconds: 1),
                            backgroundColor: Colors.blue,
                          );
                          setState(() {});
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
                            : const Text("Edit Jadwal"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
