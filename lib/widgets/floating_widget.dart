import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/add_todo.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const AddTodo()));
      },
      backgroundColor: const Color.fromARGB(255, 88, 236, 255),
      label: const Text(
        "Add TODO",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      icon: const Icon(
        Icons.edit,
        color: Colors.black,
      ),
    );
  }
}
