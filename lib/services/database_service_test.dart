import 'package:nullshop/models/user_model.dart';
import 'package:nullshop/services/database_service_interface.dart';

class TestDatabaseService extends DatabaseServiceInterface {
  @override
  Future<void> createUserFromModel({required User user}) {
    throw UnimplementedError();
  }

  @override
  Future<User?> getUserFromUid({required String uid}) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserFromUid({required String uid, required User user}) {
    throw UnimplementedError();
  }
}
