import 'package:flutter/material.dart';

class PlanningTaskWidget extends StatelessWidget {
  const PlanningTaskWidget(
      {super.key,
      required this.taskData,
      this.isToday = false,
      this.isTomorrow = false,
      required this.onPressedCallBack});

  final Map<String, dynamic> taskData;
  final bool isToday;
  final bool isTomorrow;
  final VoidCallback onPressedCallBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 0,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(taskData['name']),
            IconButton(
                onPressed: () => onPressedCallBack(),
                icon: Icon(
                  isToday
                      ? Icons.arrow_drop_down
                      : isTomorrow
                          ? Icons.arrow_left
                          : Icons.arrow_right,
                  size: 50,
                  color: isToday
                      ? Colors.green
                      : isTomorrow
                          ? Colors.blue
                          : Colors.red,
                ))
          ],
        ),
      ),
    );
  }
}
