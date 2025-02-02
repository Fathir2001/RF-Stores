class DairyItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  DairyItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
  factory DairyItem.fromJson(Map<String, dynamic> json) {
    return DairyItem(
      id: json['_id'],
      name: json['name'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
    );
  }
}
