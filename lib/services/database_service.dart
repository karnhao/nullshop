import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nullshop/models/product_model.dart';
import 'package:nullshop/models/user_model.dart';
import 'package:nullshop/services/database_service_interface.dart';

class DatabaseService extends DatabaseServiceInterface {
  final FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;

  @override
  Future<void> createUserFromModel({required User user}) async {
    final docUser = _firebaseStore.collection("users").doc(user.uid);
    final Map<String, dynamic> userInfo = user.toMap();
    await docUser.set(userInfo);
  }

  @override
  Future<User?> getUserFromUid({required String uid}) async {
    final docUser = _firebaseStore.collection('users').doc(uid);
    final snapshot = await docUser.get();

    if (!snapshot.exists) return null;

    final userInfo = snapshot.data();
    return User.fromMap(userMap: userInfo!);
  }

  @override
  Future<void> updateUserFromUid(
      {required String uid, required User user}) async {
    final docUser = _firebaseStore.collection("users").doc(uid);
    await docUser.set(user.toMap());
  }

  @override
  Future<List<Product?>> getFutureListProduct() async {
    final snapshot = await _firebaseStore.collection("products").get();
    return snapshot.docs
        .map((t) => Product.fromMap(productMap: t.data()))
        .toList();
  }

  @override
  Future<void> createProduct({required Product product}) async {
    final docs = _firebaseStore.collection("products").doc(product.uid);
    await docs.set(product.toMap());
  }

  @override
  Stream<List<Product?>> getStreamListProduct() =>
      _firebaseStore.collection('products').snapshots().map((t) =>
          t.docs.map((u) => Product.fromMap(productMap: u.data())).toList());

  @override
  Future<void> addProduct({required Product product}) async {
    final docProduct = _firebaseStore.collection('products').doc();
    final newProduct = Product(
        name: product.name,
        price: product.price,
        quantity: product.quantity,
        category: product.category,
        description: product.description,
        photoURL: product.photoURL,
        uid: docProduct.id);
    await docProduct.set(newProduct.toMap());
  }

  @override
  Future<void> buyProduct(
      {required String userUid,
      required String productUid,
      required int buyAmount}) async {
    final user = await getUserFromUid(uid: userUid);
    final product = await getProductFromUid(uid: productUid);
    if (user == null || product == null) {
      throw Exception("User or product not found");
    }
    if (product.quantity < buyAmount) {
      throw Exception("Out of product, try decrease some buy amount");
    }
    if ((user.coin ?? 0) < product.price * buyAmount) {
      throw Exception("Not enough coin.");
    }
    user.coin = user.coin! - (product.price * buyAmount);

    final updatedProduct = Product(
        name: product.name,
        price: product.price,
        quantity: product.quantity - buyAmount,
        category: product.category,
        description: product.description,
        photoURL: product.photoURL,
        uid: productUid);

    await updateUserFromUid(uid: user.uid, user: user);
    await updateProductFromUid(uid: productUid, product: updatedProduct);
  }

  @override
  Future<void> removeProduct({required String uid}) async {
    await _firebaseStore.collection('products').doc(uid).delete();
  }

  @override
  Future<Product?> getProductFromUid({required String uid}) async {
    final snapshot = await _firebaseStore.collection('products').doc(uid).get();
    if (!snapshot.exists || snapshot.data() == null) return null;
    return Product.fromMap(productMap: snapshot.data()!);
  }

  @override
  Future<void> updateProductFromUid(
      {required String uid, required Product product}) async {
    await _firebaseStore.collection("products").doc(uid).set(product.toMap());
  }
}
