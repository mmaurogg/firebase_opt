class Product {
  final String id;
  final List<String?> appId;
  final String name;
  final double price;
  final String? imageUrl;

  Product({
    required this.id,
    required this.appId,
    required this.name,
    required this.price,
    this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      appId: json['appId'] != null ? List<String>.from(json['appId']) : [],
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appId': appId,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
