class Product {
  final String id;
  final String? appid;
  final String name;
  final double price;
  final String? imageUrl;

  Product(
    this.appid,
    this.imageUrl, {
    required this.id,
    required this.name,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['appId'] as String?,
      json['imageUrl'] as String?,
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appId': appid,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
