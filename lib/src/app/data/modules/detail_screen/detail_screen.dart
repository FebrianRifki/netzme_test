import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key, required this.taskData});

  final Map<String, dynamic> taskData;
  List<String> list = <String>['Hari ini', 'Kemarin', 'Besok'];
  String dropdownValue = 'Hari ini';
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var dueDate = taskData['due_date'];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
                height: 30,
                decoration: const BoxDecoration(color: Colors.blue),
                child: Center(
                    child: Text('Detail Jadwal',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: taskNameController
                            ..text = taskData['name'],
                          readOnly: true,
                          decoration: const InputDecoration(
                              label: Text('Nama jadwal'),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 100,
                          padding: const EdgeInsets.only(left: 10.0, top: 13.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(taskData['due_date']),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: size.height * 0.12,
                          child: TextFormField(
                            controller: statusController
                              ..text = taskData['status'],
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'status jadwal',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            maxLines:
                                null, // Ini akan memungkinkan teks input untuk diperpanjang secara otomatis.
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.12,
                          child: TextFormField(
                            controller: descriptionController
                              ..text = taskData['description'],
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'deskripsi jadwal',
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
          ],
        ),
      ),
    );
  }
}
