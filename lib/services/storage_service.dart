import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:nullshop/utils/show_snack_bar.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String?> uploadProductImage({required File imageFile}) async {
    String unixTime = DateTime.now().toUtc().millisecondsSinceEpoch.toString();
    try {
      final fileName = imageFile.path.split("/").last;
      final fileNameArray = fileName.split(".");
      final fileNameAndTime =
          '${fileNameArray[0]}$unixTime${fileNameArray.last}';
      final uploadTask = await _firebaseStorage
          .ref('products/$fileNameAndTime')
          .putFile(imageFile);
      return uploadTask.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      showSnackBar(e.message);
    } catch (e) {
      showSnackBar('$e');
    }
    return null;
  }

  Future<void> removeProductImage({required String url}) async {
    await _firebaseStorage.refFromURL(url).delete();
  }
}
