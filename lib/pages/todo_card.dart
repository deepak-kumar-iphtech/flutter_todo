import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/item_schema.dart';
import 'package:http/http.dart' as http;

class TodoCard extends StatefulWidget {
  const TodoCard({super.key, required this.items});

  final Item items;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  List<Item> items = [];
  @override
  Widget build(BuildContext context) {
    final id = widget.items.id;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Card(
          elevation: 7.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  child: Text("1"),
                ),
                Column(
                  children: [
                    Text(widget.items.title),
                    Text(widget.items.description)
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.delete)),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.edit_note))
                  ],
                )
              ],
            ),
          )),
    );
  }
}
