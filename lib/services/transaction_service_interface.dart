import 'package:nullshop/models/transaction_model.dart';

abstract class TransactionServiceInterface {
  /// update ข้อมูลเข้าฐานข้อมูล
  ///
  /// uid ต้องเป็น uid ของผู้ใช้ที่จะถูกบรรทึก
  Future<void> update(String uid, TransactionCollection tc);
  Future<TransactionCollection?> get(String uid);
}
