class Coffee {
  final String name;
  final String price;
  final String imagePath;

  Coffee({
    required this.name,
    required this.price,
    required this.imagePath,
  });

  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(
      name: json['name'] ?? '', // Use default value if name is null
      price: json['price'] ?? '', // Use default value if price is null
      imagePath: json['imgPath'] ?? '', // Use default value if imagePath is null
    );
  }
}