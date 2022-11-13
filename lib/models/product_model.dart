enum ProductCategory {
  pen,
  book,
  eraser,
  food,
  drink,
  gun,
  nuke,
  deathStar,
  other
}

class Product {
  final String? uid;
  final String name;
  final String? description;
  final ProductCategory? category;
  final double price;
  final int quantity;
  final String? photoURL;

  Product(
      {this.uid,
      this.description,
      required this.name,
      this.photoURL,
      required this.price,
      required this.quantity,
      this.category});

  Product.fromMap({required Map<String, dynamic> productMap})
      : uid = productMap["uid"],
        description = productMap["description"],
        category = getProductCategory(productMap["category"]),
        price = double.parse(productMap["price"].toString()),
        quantity = int.parse(productMap["quantity"].toString()).floor(),
        name = productMap["name"],
        photoURL = productMap["photoURL"];

  Map<String, dynamic> toMap() => {
        "uid": uid ?? "",
        "name": name,
        "description": description ?? "NO DESCRIPTION",
        "category": category?.name.toString() ?? "book",
        "price": price,
        "quantity": quantity,
        "photoURL": photoURL ?? "",
      };

  static ProductCategory? getProductCategory(String type) {
    switch (type.toLowerCase()) {
      case "pen":
        return ProductCategory.pen;
      case "book":
        return ProductCategory.book;
      case "eraser":
        return ProductCategory.eraser;
      case "gun":
        return ProductCategory.gun;
      case "food":
        return ProductCategory.food;
      case "drink":
        return ProductCategory.drink;
      case "nuke":
        return ProductCategory.nuke;
      case "deathstar":
        ProductCategory.deathStar;
    }
    return ProductCategory.other;
  }
}
