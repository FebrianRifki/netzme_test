import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/src/app/cores/enum/bottom_navigato_bar_item.dart';
import 'package:to_do_list/src/app/data/modules/create_task_screen/create_task_screen.dart';
import 'package:to_do_list/src/app/data/modules/tasks_screen/task_controller.dart';
import 'package:to_do_list/src/app/data/modules/task_list_screen/task_list_screen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  int _selectedIndex = 1;
  TaskController controller = Get.put(TaskController());
  static List<Widget> pages = <Widget>[
    TaskListScreen(
      isYesterday: true,
    ),
    TaskListScreen(
      isToday: true,
    ),
    TaskListScreen(
      isTomorrow: true,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
