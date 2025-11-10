import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late double _deviceHeight, _deviceWidth;
  
  String? _newTaskContent;

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
      body: _tasksList(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _tasksList() {
    return ListView(
      children: [
        ListTile(
          title: Text('Do Laundry'),
          subtitle: Text(DateTime.now().toString()),
          trailing: Icon(Icons.check_box_outlined, color: Colors.red),

        ),
        ListTile(
          title: Text('Do Laundry'),
          subtitle: Text(DateTime.now().toString()),
          trailing: Icon(Icons.check_box_outlined, color: Colors.red),

        ),
        ListTile(
          title: Text('Do Laundry'),
          subtitle: Text(DateTime.now().toString()),
          trailing: Icon(Icons.check_box_outlined, color: Colors.red),

        ),
        ListTile(
          title: Text('Do Laundry'),
          subtitle: Text(DateTime.now().toString()),
          trailing: Icon(Icons.check_box_outlined, color: Colors.red),

        ),
        ListTile(
          title: Text('Do Laundry'),
          subtitle: Text(DateTime.now().toString()),
          trailing: Icon(Icons.check_box_outlined, color: Colors.red),

        ),
       
      ],
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
          onSubmitted: (_value) => {},
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
