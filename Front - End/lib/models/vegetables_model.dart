class VegetableItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  VegetableItem ({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
  factory VegetableItem.fromJson(Map<String, dynamic> json) {
    return VegetableItem(
      id: json['_id'],
      name: json['name'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
    );
  }
}