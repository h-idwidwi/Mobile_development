import 'package:flutter/material.dart';
import 'task_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TODOApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TODO(),
    );
  }
}

class TODO extends StatefulWidget {
  @override
  TODOState createState() => TODOState();
}

class TODOState extends State<TODO> {
  late Box<Task> todosBox;
  bool showCompleted = false;

  void openTaskEditor({Task? task, int? index}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskEditorScreen(
          task: task,
          onSave: (taskName, taskDesc) {
            if (task != null) {
              task.task = taskName;
              task.description = taskDesc;
              todosBox.putAt(index!, task);
            } 
            else {
              todosBox.add(Task(task: taskName, description: taskDesc, completed: false));
            }
            Navigator.pop(context);
          },
          onDelete: () {
            if (task != null) {
              todosBox.deleteAt(index!);
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
        backgroundColor: Colors.blue.shade900,
        actions: [
          IconButton(
            icon: Icon(showCompleted ? Icons.check_box : Icons.list_alt_outlined),
            onPressed: () {
              setState(() {
                showCompleted = !showCompleted;
              });
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: todosBox.listenable(),
        builder: (context, Box<Task> box, _) {
          final tasks = box.values.toList().cast<Task>();
          final filteredTasks = tasks.where((task) => task.completed == showCompleted).toList();

          if (filteredTasks.isEmpty) {
            return Center(child: Text(
              'Нет запланированных задач',
              textAlign: TextAlign.center,
              style: TextStyle(
                    fontSize: 30,
                  ),
              )
            );
          }

          return ListView.builder(
            itemCount: filteredTasks.length,
            itemBuilder: (context, index) {
              final task = filteredTasks[index];
              return ListTile(
                title: Text(
                  task.task,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  task.description,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                trailing: Checkbox(
                  value: task.completed,
                  onChanged: (value) {
                    setState(() {
                      task.completed = value!;
                      box.putAt(index, task);
                    });
                  },
                ),
                onTap: () => openTaskEditor(task: task, index: index),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openTaskEditor(),
        child: Icon(Icons.add_circle_outline),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    todosBox = Hive.box<Task>('TODOs');
  }

  @override
  void dispose() {
    todosBox.compact();
    super.dispose();
  }
}

class TaskEditorScreen extends StatelessWidget {
  final Task? task;
  final Function(String, String) onSave;
  final VoidCallback? onDelete;

  final TextEditingController nameController;
  final TextEditingController descController;

  TaskEditorScreen({
    Key? key,
    this.task,
    required this.onSave,
    this.onDelete,
  })  : nameController = TextEditingController(text: task?.task),
        descController = TextEditingController(text: task?.description),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String titleText;
    if (task == null) {
      titleText = 'Добавить задачу';
    } 
    else {
      titleText = 'Редактировать задачу';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        actions: [
          if (onDelete != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Название задачи'),
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: 'Описание задачи'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onSave(nameController.text, descController.text);
              },
              child: Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
