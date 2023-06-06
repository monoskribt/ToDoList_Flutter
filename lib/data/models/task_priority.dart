import 'package:flutter/material.dart';

enum TaskPriority {
  low(
    Icon(
      Icons.low_priority,
      color: Colors.blue,
    ),
    'Низкий приоритет',
  ),
  medium(
    Icon(
      Icons.density_medium,
      color: Colors.orange,
    ),
    'Средний приоритет',
  ),
  hight(
    Icon(
      Icons.priority_high,
      color: Colors.red,
    ),
    'Высокий приоритет',
  );


  const TaskPriority(this.icon, this.text);
  final Icon icon;
  final String text;
}
