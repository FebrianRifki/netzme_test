import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/src/app/cores/enum/bottom_navigato_bar_item.dart';
import 'package:to_do_list/src/app/data/modules/create_task_screen/create_task_screen.dart';
import 'package:to_do_list/src/app/data/modules/widgets/task_list_widget.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  int _selectedIndex = 1;
  static List<Widget> pages = <Widget>[
    const TaskListWidget(
      isYesterday: true,
    ),
    const TaskListWidget(
      isToday: true,
    ),
    const TaskListWidget(
      isTomorrow: true,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => const CreateTaskScreen());
          },
          backgroundColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Center(child: pages.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.white, // Warna teks label tidak terpilih
          selectedItemColor: Colors.white,
          backgroundColor: Colors.blue,
          items: bottomNavigationBarItem,
          selectedIconTheme: const IconThemeData(opacity: 0.0, size: 0),
          unselectedIconTheme: const IconThemeData(opacity: 0.0, size: 0),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
