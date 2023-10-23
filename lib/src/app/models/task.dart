import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String name;
  final String status;
  final String description;
  final String email;
  Task(
      {required this.id,
      required this.name,
      required this.status,
      required this.description,
      required this.email});

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'due_date': status,
        'description': description,
        'status': 'On-progress',
        'created_at': status == 'Hari ini'
            ? Timestamp.fromDate(DateTime.now())
            : status == 'Besok'
                ? Timestamp.fromDate(
                    DateTime.now().add(const Duration(days: 1)))
                : Timestamp.fromDate(
                    DateTime.now().subtract(const Duration(days: 1)))
      };
}
