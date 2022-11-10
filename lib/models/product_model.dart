enum ProductCategory { pen, book, eraser, gun }

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

  Product.fromMap({required Map<String, dynamic> usermap})
      : uid = usermap["uid"],
        description = usermap["description"],
        category = usermap["category"],
        price = usermap["price"],
        quantity = usermap["quantity"],
        name = usermap["name"],
        photoURL = usermap["photoURL"];

  Map<String, dynamic> toMap() => {
        "uid": uid ?? "",
        "name": name,
        "description": description ?? "NO DESCRIPTION",
        "category": category ?? "book",
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
    }
    return null;
  }
}
