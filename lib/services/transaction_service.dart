import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nullshop/models/transaction_model.dart';
import 'package:nullshop/services/transaction_service_interface.dart';

class TranSactionService extends TransactionServiceInterface {
  final FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;
  @override
  Future<void> update(String uid, TransactionCollection tc) async {
    await _firebaseStore.collection('transactions').doc(uid).set(tc.toMap());
  }

  @override
  Future<TransactionCollection?> get(String uid) async {
    final data =
        (await _firebaseStore.collection('transactions').doc(uid).get()).data();
    if (data == null) return TransactionCollection(uid: uid, items: []);
    return TransactionCollection.fromMap(data);
  }
}
