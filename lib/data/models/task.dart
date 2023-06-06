import 'dart:ui';

import 'package:untitled/data/models/task_priority.dart';

class Task {
  const Task({
    required this.id,
    required this.title,
    required this.taskPriority,
    this.isDone = false,
    this.subtitle,
    this.color,
  });
  final String id;
  final Color? color;
  final bool isDone;
  final String title;
  final String? subtitle;
  final TaskPriority taskPriority;

  Task copyWith({
    String? id,
    bool? isDone,
    Color? color,
    String? title,
    String? subtitle,
    TaskPriority? taskPriority,
})  {
    return Task(
      id: id ?? this.id,
      isDone: isDone ?? this.isDone,
      color: color ?? this.color,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      taskPriority: taskPriority ?? this.taskPriority,
    );
  }
}