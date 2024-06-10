import 'dart:convert';
import 'package:flutter_application_1/models/item_schema.dart';
import 'package:http/http.dart' as http;

class ItemAPI {
  static Future<List<Item>> fetchTodo() async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final json = jsonDecode(response.body) as Map;
    final result = json['items'] as List<dynamic>;
    final items = result.map((index) => Item.fromMap(index)).toList();
    return items;
  }
}
