import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/src/app/data/modules/edit_task_screen/edit_task_screen.dart';
import 'package:to_do_list/src/app/data/modules/widgets/done_task_widget.dart';
import 'package:to_do_list/src/app/data/modules/widgets/planning_task_widget.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget(
      {super.key,
      this.isToday = false,
      this.isYesterday = false,
      this.isTomorrow = false});
  final bool isToday;
  final bool isYesterday;
  final bool isTomorrow;

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Container(
            height: 30,
            decoration: const BoxDecoration(color: Colors.blue),
            child: Center(
                child: Text(
                    widget.isToday
                        ? 'Jadwal Hari ini'
                        : widget.isYesterday
                            ? 'Jadwal Kemaren'
                            : 'Jadwal Besok',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .merge(const TextStyle(color: Colors.white))))),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rencana:',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: widget.isToday
                        ? Colors.lightBlue
                        : (widget.isYesterday ? Colors.red : Colors.blue)),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () => Get.to(const EditTaskScreen()),
                  child: const PlanningTaskWidget()),
              const PlanningTaskWidget(),
              const PlanningTaskWidget(),
              const PlanningTaskWidget(),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selesai:',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: widget.isToday
                        ? Colors.lightBlue
                        : (widget.isYesterday ? Colors.red : Colors.blue)),
              ),
              const SizedBox(
                height: 10,
              ),
              const DoneTaskWidget(),
              const DoneTaskWidget(),
              const DoneTaskWidget(),
              const DoneTaskWidget(),
            ],
          ),
        )
      ],
    ));
  }
}
