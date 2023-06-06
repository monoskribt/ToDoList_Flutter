import 'package:flutter/material.dart';
import 'package:untitled/data/controllers/list_notifier.dart';
import 'package:untitled/data/models/task.dart';
import 'package:untitled/data/models/task_priority.dart';
import 'package:untitled/view/widgets/color_picker.dart';
import 'package:untitled/view/widgets/dropdown_priority_picker.dart';
import 'package:untitled/view/widgets/title_textfield.dart';
import 'package:uuid/uuid.dart';

class EdditTaskPage extends StatelessWidget {
  EdditTaskPage({super.key, required this.listNotifier, this.task});
  final Task? task;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final ListNotifier listNotifier;
  final ValueNotifier<Color> colorNotifier = ValueNotifier(Colors.white);
  final ValueNotifier<TaskPriority> priorityNotifier =
      ValueNotifier(TaskPriority.hight);

  final ValueNotifier<String?> errorTextFieldNotifier = ValueNotifier(null);

  String? errorText;

  TextEditingController setTitleController(Task? task) {
    if (task == null) return titleController;
    titleController.text = task.title;
    return titleController;
  }

  TextEditingController setSubtitleController(Task? task) {
    if (task == null) return descController;
    descController.text = task.subtitle ?? '';
    return descController;
  }

  ValueNotifier<TaskPriority> setPriorityNotifier(Task? task) {
    if (task == null) return priorityNotifier;
    priorityNotifier.value = task.taskPriority;
    return priorityNotifier;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(35.0),
          child: SingleChildScrollView(
            child: Column(children: [
              const Text(
                'Название задачи',
                style: TextStyle(fontSize: 17.0),
              ),
              const SizedBox(height: 15),
              TitleTextField(
                setController: setTitleController(task),
                errorTextNotifier: errorTextFieldNotifier,
              ),
              const SizedBox(height: 15),
              const Text(
                'Описание задачи',
                style: TextStyle(fontSize: 17.0),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: setSubtitleController(task),
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 14,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1.5, color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.purple),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ColorPicker(
                colorNotifier: colorNotifier,
                task: task,
              ),
              const SizedBox(height: 20),
              DropdownPriorityPicker(
                priorityNotifier: setPriorityNotifier(task),
                initialDropdownValue: task?.taskPriority,
              ),
              const SizedBox(height: 25),
              if (task == null)
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isEmpty) {
                      errorText = 'Пожалуйста, введите название';
                      errorTextFieldNotifier.value = errorText ?? '';
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Должно быть указано хотя бы название задачи',
                          ),
                        ),
                      );
                      return;
                    }
                    listNotifier.addTask(
                      Task(
                        id: const Uuid().v4(),
                        color: colorNotifier.value,
                        title: titleController.text,
                        subtitle: descController.text,
                        taskPriority: priorityNotifier.value,
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.grey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Добавить задачу',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              if (task != null)
                ElevatedButton(
                  onPressed: () {
                    listNotifier.updateTask(
                        task!.id,
                        task!.copyWith(
                          color: colorNotifier.value,
                          title: titleController.text,
                          subtitle: descController.text,
                          taskPriority: priorityNotifier.value,
                        ),
                    );
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.grey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Обновить задачу',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
            ]),
          ),
        ),
      ),
    );
  }
}
