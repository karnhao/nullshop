import 'package:cloud_firestore/cloud_firestore.dart';
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
}
