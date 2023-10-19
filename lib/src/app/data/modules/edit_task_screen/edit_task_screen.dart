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
                        TextFormField(
                          controller: taskNameController,
                          decoration: const InputDecoration(
                              label: Text('Nama Task'),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: DropdownMenu<String>(
                            initialSelection: widget.taskData["due_date"],
                            onSelected: (String? value) {
                              // This is called when the user selects an item.
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
                            maxLines:
                                null, // Ini akan memungkinkan teks input untuk diperpanjang secara otomatis.
                          ),
                        )
                      ],
                    )),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              width: double
                  .infinity, // Ini memastikan widget mengisi lebar penuh layar.
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        var updatedData = {
                          'name': taskNameController.text,
                          'due_date': dropdownValue,
                          'description': descriptionController.text
                        };
                        controller.updateTask(
                            widget.taskData['id'], updatedData);
                      },
                      child: const Text('Simpan Jadwal'),
                    ),
                  ),
                  const SizedBox(
                      width: 10), // Menambahkan jarak horizontal antara tombol.
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
