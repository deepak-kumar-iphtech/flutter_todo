import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  /// Used to store text
  TextEditingController titleControler = TextEditingController();
  TextEditingController decsriptionControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD TODO"),
      ),
      backgroundColor: const Color.fromARGB(255, 57, 57, 57),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: titleControler,
              decoration: const InputDecoration(
                  labelText: "Title", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: decsriptionControler,
              minLines: 5,
              maxLines: 5,
              decoration: const InputDecoration(
                  labelText: "Description", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 88, 236, 255)),
                onPressed: submitData,
                child: const Text(
                  "Submit",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> submitData() async {
    //Get the data from FORM
    final title = titleControler.text;
    final description = decsriptionControler.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };

    //Encode the body to send in string
    final encodedBody = jsonEncode(body);

    //Submit the data
    const url = "https://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: encodedBody, headers: {'Content-Type': 'application/json'});

    //Show success or fail message
    //Add snack bar
    if (response.statusCode == 201) {
      titleControler.text = '';
      decsriptionControler.text = '';

      // ignore: use_build_context_synchronously
      Navigator.pop(
        // ignore: use_build_context_synchronously
        context,
      );
    } else {
      //print('error');
    }
  }
}
