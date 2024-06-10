class Item {
  final String id;
  final String title;
  final String description;

  Item({required this.id, required this.title, required this.description});

  factory Item.fromMap(Map<String, dynamic> json) {
    return Item(
        id: json['_id'],
        title: json['title'],
        description: json['description']);
  }
}
