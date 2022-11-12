class TransactionObject {
  String? collectionUID;
  String? time;
  int? timeMillis;
  final String productName;
  final double productPrice;
  final int productCount;

  TransactionObject(
      {required this.productName,
      required this.productPrice,
      required this.productCount,
      this.time,
      this.collectionUID,
      this.timeMillis});
}

class TransactionCollection {
  final String uid;
  final List<TransactionObject> items;

  TransactionCollection({required this.uid, required this.items});

  static TransactionCollection fromMap(
      Map<String, dynamic> transactionCollectionMap) {
    final List<Map<String, dynamic>> l =
        (transactionCollectionMap["items"] as List<dynamic>).map((t) {
      return {
        "name": t["name"],
        "price": t["price"],
        "count": t["count"],
        "time": t["time"],
        "timeMillis": t["timeMillis"]
      };
    }).toList();

    return TransactionCollection(
        uid: transactionCollectionMap["uid"],
        items: l
            .map((t) => TransactionObject(
                productName: t["name"],
                productPrice: double.parse(t["price"].toString()),
                productCount: int.parse(t["count"].toString()),
                time: t["time"],
                timeMillis: t["timeMillis"]))
            .toList());
  }

  Map<String, dynamic> toMap() {
    final map = {
      "uid": uid,
      "items": items.map((t) {
        return {
          "name": t.productName,
          "price": t.productPrice,
          "count": t.productCount,
          "time": t.time,
          "timeMillis": t.timeMillis
        };
      }).toList()
    };

    return map;
  }
}
