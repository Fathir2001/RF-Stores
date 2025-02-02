class PantryItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  PantryItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
  factory PantryItem.fromJson(Map<String, dynamic> json) {
    return PantryItem(
      id: json['_id'],
      name: json['name'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
    );
  }
}