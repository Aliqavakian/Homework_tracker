import 'package:equatable/equatable.dart';

class Task extends Equatable {
  const Task({
    this.id,
    required this.subject,
    required this.title,
    required this.dueDateMillis,
    required this.completed,
  });

  final int? id;
  final String subject;
  final String title;
  final int dueDateMillis;
  final bool completed;

  Task copyWith({
    int? id,
    String? subject,
    String? title,
    int? dueDateMillis,
    bool? completed,
  }) {
    return Task(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      title: title ?? this.title,
      dueDateMillis: dueDateMillis ?? this.dueDateMillis,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subject': subject,
      'title': title,
      'due_date_millis': dueDateMillis,
      'completed': completed ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      subject: map['subject'] as String,
      title: map['title'] as String,
      dueDateMillis: map['due_date_millis'] as int,
      completed: map['completed'] == 1,
    );
  }

  @override
  List<Object?> get props => [id, subject, title, dueDateMillis, completed];
}