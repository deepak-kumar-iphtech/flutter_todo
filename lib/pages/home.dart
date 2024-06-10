import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/get_api.dart';
import 'package:flutter_application_1/models/item_schema.dart';
import 'package:flutter_application_1/widgets/floating_widget.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Item> items = [];
  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    //print("build");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TODO APP",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 57, 57, 57),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final id = item.id;
                return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Text(
                        '${index + 1}',
                        //style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(item.title),
                    subtitle: Text(item.description),
                    trailing: PopupMenuButton(onSelected: (value) {
                      if (value == 'delete') {
                        deleteById(id);
                      } else if (value == 'edit') {}
                    }, itemBuilder: (value) {
                      return [
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('DELETE'),
                        ),
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('EDIT'),
                        )
                      ];
                    }));
              }),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: const FloatingButton(),
    );
  }

  Future<void> deleteById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      final filtered = items.where((element) => element.id != id).toList();
      setState(() {
        items = filtered;
      });
    }
  }

  Future<void> fetchTodo() async {
    setState(() {
      isLoading = true;
    });
    final result = await ItemAPI.fetchTodo();
    setState(() {
      items = result;
    });
    setState(() {
      isLoading = false;
    });
  }
}
