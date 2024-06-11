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
  bool isLoading = true;
  List<Item> items = [];
  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TODO APP",
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
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Card(
                      elevation: 7.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              child: Text('${index + 1}'),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    item.description,
                                    style: const TextStyle(
                                        fontSize: 12.0, color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      deleteById(id);
                                    },
                                    icon: const Icon(Icons.delete_forever)),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit_note))
                              ],
                            )
                          ],
                        ),
                      )),
                );
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
    // setState(() {
    //   isLoading = true;
    // });
    final result = await ItemAPI.fetchTodo();
    setState(() {
      items = result;
    });
    setState(() {
      isLoading = false;
    });
  }
}
