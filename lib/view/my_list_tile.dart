import 'package:flutter/material.dart';
import 'package:untitled/data/controllers/list_notifier.dart';
import 'package:untitled/data/models/task.dart';
import 'package:untitled/view/edit_task_page.dart';

class MyListTile extends StatefulWidget {
  const MyListTile({
    Key? key,
    required this.task,
    required this.listNotifier,
    this.disableObTap = false,
  }) : super(key: key);

  final Task task;
  final ListNotifier listNotifier;
  final bool disableObTap;

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {

  @override
  Widget build(BuildContext context) {
    final checkboxValue = widget.task.isDone;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: !checkboxValue ? widget.task.color ?? Colors.white : Colors.grey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Checkbox(
              value: checkboxValue,
              onChanged: (bool? value) {
                setState(() {
                  widget.listNotifier.toggleDone(widget.task);
                });
              },
            ),
            title: Text(widget.task.title),
            subtitle: Text(widget.task.subtitle ?? ''),
            trailing: widget.task.taskPriority.icon,
            style: ListTileStyle.list,
            onTap: () => widget.disableObTap ? null : Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EdditTaskPage(
                  listNotifier: widget.listNotifier,
                  task: widget.task,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
