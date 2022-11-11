import 'package:nullshop/models/product_model.dart';
import 'package:nullshop/models/user_model.dart';

abstract class DatabaseServiceInterface {
  Future<void> createUserFromModel({required User user});
  Future<User?> getUserFromUid({required String uid});
  Future<void> updateUserFromUid({required String uid, required User user});
  Future<void> createProduct({required Product product});
  Future<List<Product?>> getFutureListProduct();
  Stream<List<Product?>> getStreamListProduct();
  Future<void> addProduct({required Product product});
}
