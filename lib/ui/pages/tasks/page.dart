import 'package:flutter/material.dart';
import 'package:matreshka_test_task/ui/global_components/close_button.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Tasks',
          style: TextStyle(fontSize: 50),
        ),
      ),
      floatingActionButton: CustomCloseButton(
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
