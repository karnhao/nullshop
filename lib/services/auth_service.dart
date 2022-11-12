import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nullshop/models/user_model.dart';
import 'package:nullshop/services/database_service_interface.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final DatabaseServiceInterface _databaseService;

  AuthService({required DatabaseServiceInterface dbs}) : _databaseService = dbs;

  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      final userUid = userCredential.user?.uid;
      final user = await _databaseService.getUserFromUid(uid: userUid!);
      return user;
    } on auth.FirebaseAuthException catch (e) {
      throw "${e.message}";
    } catch (e) {
      throw "$e";
    }
  }

  Future<Map<dynamic, dynamic>> signInWithGoogle(
      {required GoogleSignInAccount googleUser}) async {
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final auth.OAuthCredential googleCredential =
        auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final auth.UserCredential googleUserCredential =
        await _firebaseAuth.signInWithCredential(googleCredential);

    if (googleUserCredential.user == null) {
      throw Exception("Create user with google failed!");
    }

    final newUser = User(
        uid: googleUserCredential.user!.uid,
        email: googleUserCredential.user!.email!,
        username: googleUserCredential.user!.displayName!,
        coin: 0,
        role: "user");

    final isFirstLogin =
        googleUserCredential.additionalUserInfo?.isNewUser ?? false;

    if (isFirstLogin) {
      await _databaseService.createUserFromModel(user: newUser);
    }

    return {
      "user": newUser,
      "firstTimeSignIn":
          googleUserCredential.additionalUserInfo?.isNewUser ?? false
    };
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<User> createUser(
      {required String email,
      required String username,
      required String password,
      String? role,
      String? phone,
      String? address,
      double? coin}) async {
    final userCredetial = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (userCredetial.user == null) {
      throw Exception("Create user with email and password failed!");
    }
    final newUser = User(
        uid: userCredetial.user!.uid,
        email: email,
        username: username,
        address: address,
        coin: 0,
        phone: phone,
        role: 'user');
    try {
      await _databaseService.createUserFromModel(user: newUser);
    } catch (e) {
      throw Exception("Failed to create user! $e");
    }

    return newUser;
  }

  Future<User?> getCurrentUser() async {
    if (_firebaseAuth.currentUser == null) return null;
    return await _databaseService.getUserFromUid(
        uid: _firebaseAuth.currentUser!.uid);
  }
}
