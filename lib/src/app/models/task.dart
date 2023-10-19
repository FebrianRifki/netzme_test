class Task {
  final String id;
  final String name;
  final String status;
  final String description;
  Task(
      {required this.id,
      required this.name,
      required this.status,
      required this.description});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'due_date': status,
        'description': description,
        'status': 'On-progress',
        'created_at': DateTime.now()
      };
}
