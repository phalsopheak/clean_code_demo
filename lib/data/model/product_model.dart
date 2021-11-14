class ProductModel {
  final int id;
  final String name;
  final double price;
  final String category;
  final String? picture;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.picture,
  });
}
