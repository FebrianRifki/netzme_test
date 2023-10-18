import 'package:flutter/material.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key, required this.taskData});
  final Map<String, dynamic> taskData;
  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  List<String> list = <String>['Hari ini', 'Kemarin', 'Besok'];
  String dropdownValue = 'Hari ini';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
              Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    children: [
                      TextFormField(
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
                          initialSelection: list.first,
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
                        height: 10,
                      ),
                      SizedBox(
                        height: size.height * 0.3,
                        child: const TextField(
                          decoration: InputDecoration(
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
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
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
                        onPressed: () {},
                        child: Text('Simpan Jadwal'),
                      ),
                    ),
                    const SizedBox(
                        width:
                            10), // Menambahkan jarak horizontal antara tombol.
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {},
                        child: Text('Hapus Jadwal'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
