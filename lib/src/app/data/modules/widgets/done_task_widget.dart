import 'package:flutter/material.dart';

class DoneTaskWidget extends StatelessWidget {
  const DoneTaskWidget({super.key, required this.taskData});
  final Map<String, dynamic> taskData;

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
            Text(
              taskData['name'],
              style: const TextStyle(decoration: TextDecoration.lineThrough),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_right,
                  size: 50,
                ))
          ],
        ),
      ),
    );
  }
}
