class Task {
  final String name;
  final String status;
  final String description;
  Task({required this.name, required this.status, required this.description});

  Map<String, dynamic> toJson() => {
        'name': name,
        'dueDate': status,
        'description': description,
        'status': 'On-progress',
        'created_at': DateTime.now()
      };
}
