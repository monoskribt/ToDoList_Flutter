import 'package:flutter/material.dart';
import 'package:untitled/data/controllers/list_notifier.dart';
import 'package:untitled/data/list_of_tasks.dart';
import 'package:untitled/data/models/task.dart';
import 'package:untitled/view/edit_task_page.dart';
import 'package:untitled/view/my_list_tile.dart';
import 'package:untitled/view/widgets/dismiss_background.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: FirstWidget(
        listNotifier: ListNotifier(listOfTask),
      ),
    );
  }
}

class FirstWidget extends StatelessWidget {
  const FirstWidget({super.key, required this.listNotifier});

  final ListNotifier listNotifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ValueListenableBuilder<List<Task>>(
          valueListenable: listNotifier,
          builder: (context, value, child) {
            return Column(
              children: [
                Expanded(
                  child: value.isNotEmpty
                      ? ListView.builder(
                          itemCount: value.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Dismissible(
                              secondaryBackground: const DismissBackground(
                                mainAxisAlignment: MainAxisAlignment.end,
                              ),
                              background: const DismissBackground(
                                mainAxisAlignment: MainAxisAlignment.start,
                              ),
                              onDismissed: (direction) =>
                                  listNotifier.removeTask(value[index]),
                              key: ValueKey(value[index]),
                              child: MyListTile(
                                task: value[index],
                                listNotifier: listNotifier,
                              ),
                            ),
                          ),
                        )
                      : const Center(
                          child: Text(
                            'Нет задач! Добавьте свою первую задачу',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ColoredBox(
                      color: Colors.indigo.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Выполненные задачи: ${listNotifier.listOfDoneTask.length}'
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: listNotifier.listOfDoneTask.length,
                        itemBuilder: (context, index) {
                          return MyListTile(
                            disableObTap: true,
                              task: listNotifier.listOfDoneTask[index],
                              listNotifier: listNotifier,
                          );
                      }
                    )
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Добавить задачу'),
        backgroundColor: Colors.deepPurpleAccent,
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EdditTaskPage(listNotifier: listNotifier),
            ),
          );
        },
      ),
    );
  }
}
