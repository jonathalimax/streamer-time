import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

const String EventImageDirectory = 'images/events';

class FirebaseStorageApi {
  Future<String?> uploadImage(
    File image, {
    required String name,
    String? directory,
  }) async {
    try {
      final path = directory ?? EventImageDirectory;
      final compressedImage = await FlutterNativeImage.compressImage(
        image.path,
      );
      final storageReference = FirebaseStorage.instance
          .ref()
          .child(path)
          .child('${name}_${DateTime.now().toIso8601String()}');

      final result = await storageReference.putFile(compressedImage);
      return await result.ref.getDownloadURL();
    } on FirebaseException {
      return null;
    }
  }
}
