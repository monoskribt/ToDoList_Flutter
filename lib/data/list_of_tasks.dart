import 'package:flutter/material.dart';
import 'package:untitled/data/models/task.dart';
import 'package:untitled/data/models/task_priority.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

var listOfTask = [
  Task(
    id: uuid.v4(),
    title: 'first Task',
    color: Colors.yellow,
    taskPriority: TaskPriority.low,
  ),
];
