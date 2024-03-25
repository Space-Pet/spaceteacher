import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import '../utils.dart';

class FirebaseStorageService {
  FirebaseStorageService._();

  static Future<CloudStorageResult?> uploadFile(
    File file, {
    String? fileName,
    String folder = 'uploads/profilePictures',
  }) async {
    final customFileName = fileName?.isNotEmpty == true
        ? '$fileName.${basename(file.path).split('.').last}'
        : basename(file.path);

    // Create a Reference to the file
    final ref = FirebaseStorage.instance.ref('mobile/$folder/$customFileName');

    final metadata = SettableMetadata(
      contentType: lookupMimeType(file.path),
      customMetadata: {
        'picked-file-path': file.path,
      },
    );

    final snapshot = await ref.putFile(file, metadata).catchError(
          (error, stackTrace) => LogUtils.eCatch<TaskSnapshot>(
            'putFile',
            error,
            stackTrace,
          ),
        );

    if (snapshot.state == TaskState.success) {
      return CloudStorageResult(
        url: await snapshot.ref.getDownloadURL(),
        fileName: customFileName,
      );
    }
    return null;
  }

  static Future<CloudStorageResult?> uploadImageFileWeb(
    Uint8List image, {
    String? fileName,
    String folder = 'uploads/profilePictures',
  }) async {
    LogUtils.d('uploadImageFileWeb');
    final customFileName = '${DateTime.now().millisecondsSinceEpoch}';
    final ref = FirebaseStorage.instance.ref('mobile/$folder/$customFileName');
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
    );
    final snapshot = await ref.putData(image, metadata).catchError(
          (error, stackTrace) => LogUtils.eCatch<TaskSnapshot>(
            'putFile',
            error,
            stackTrace,
          ),
        );
    if (snapshot.state == TaskState.success) {
      return CloudStorageResult(
        url: await snapshot.ref.getDownloadURL(),
        fileName: customFileName,
      );
    }
    return null;
  }
}

class CloudStorageResult {
  final String? url;
  final String? fileName;

  CloudStorageResult({this.url, this.fileName});
}
