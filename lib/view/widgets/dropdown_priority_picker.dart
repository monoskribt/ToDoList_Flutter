import 'package:flutter/material.dart';
import 'package:untitled/data/models/task_priority.dart';

class DropdownPriorityPicker extends StatefulWidget {
  DropdownPriorityPicker({
    super.key,
    required this.priorityNotifier,
    this.initialDropdownValue,
  });

  final ValueNotifier priorityNotifier;
  TaskPriority? initialDropdownValue;

  @override
  State<DropdownPriorityPicker> createState() => _DropdownPriorityPickerState();
}

class _DropdownPriorityPickerState extends State<DropdownPriorityPicker> {



  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      onChanged: (value) {
        if(value == null) return;
        setState(() {
          widget.initialDropdownValue = value as TaskPriority;
          widget.priorityNotifier.value = widget.initialDropdownValue ?? TaskPriority.hight;
        });
      },
      value: widget.initialDropdownValue ?? TaskPriority.hight,
      items: TaskPriority.values.map((element) => DropdownMenuItem(
          value: element,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Text(element.text),
                const SizedBox(
                  width: 4,
                ),
                element.icon
              ],
            ),
          )
      )).toList(),
    );
  }
}