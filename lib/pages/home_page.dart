import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskly/models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late double _deviceHeight, _deviceWidth;
  
  String? _newTaskContent;

  Box? _box;

  _HomePageState();
  
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    print("Input value is $_newTaskContent");
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.15,
        title: const Text('Taskly Home Page', 
        style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: _taskView(),
      floatingActionButton: _addTaskButton(),
    );
  }
  Widget _taskView() {
    return FutureBuilder(
      future: Hive.openBox('tasks'), 
      builder: (BuildContext context, AsyncSnapshot _snapshot) {
      if (_snapshot.hasData) {
        _box = _snapshot.data;
        return _tasksList();
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
    );
  }
  Widget _tasksList() {
    List tasks = _box?.values.toList() ?? [];
    return ListView.builder(
      itemBuilder: (BuildContext context, int index){
        var task = Task.fromMap(Map<String, dynamic>.from(tasks[index]));
        return ListTile(
          title: Text (
            task.content,
            style: TextStyle(
              fontSize: 20,
              decoration: task.done ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          subtitle: Text(task.timestamp.toString()),
          trailing: Icon(
            task.done ? Icons.check_box : Icons.check_box_outline_blank, color: Colors.red),
          onTap: () {
            task.done = !task.done;
            _box?.putAt(index, task.toMap());
            setState(() {});
          },
          onLongPress: () {
            _box?.deleteAt(index);
            setState(() {});
          },
        );
      }, 
      itemCount: tasks.length
    );
    
  }
  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: () {
        // Add task action
        _displayTaskPopup();
      },
      backgroundColor: Colors.red,
      child: const Icon(Icons.add),
    );
  }
  void _displayTaskPopup() {
    showDialog(context: context, builder: (BuildContext _context){
      return AlertDialog(
        title: const Text('Add New Task'),
        content: TextField(
          onSubmitted: (_value) {
            if (_newTaskContent != null) {
              var newTask = Task(
                content: _newTaskContent!,
                timestamp: DateTime.now(),
                done: false,
              );
              _box?.add(newTask.toMap());
              setState(() {
                _newTaskContent = null;
              });
              Navigator.of(_context).pop();
            }
          },
          onChanged:(_value) => {
            setState(() {
              _newTaskContent = _value;
            })
          },
        ),
        
      );
    });
  }
}
