import 'package:nullshop/models/user_model.dart';

abstract class DatabaseServiceInterface {
  Future<void> createUserFromModel({required User user});
  Future<User?> getUserFromUid({required String uid});
  Future<void> updateUserFromUid({required String uid, required User user});
}
