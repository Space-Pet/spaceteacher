import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';

import '../../../di/di.dart';
import '../auth_service.dart';
import '../upload_service.dart';

@Injectable(as: UploadService)
class FirebaseUploadService extends UploadService {
  @override
  Future<String?> uploadImage(File file, String fileName, String path) async {
    await injector.get<AuthService>().loginFirebase();
    final customFileName = fileName.isNotEmpty == true
        ? '$fileName.${basename(file.path).split('.').last}'
        : basename(file.path);

    // Create a Reference to the file
    final ref =
        FirebaseStorage.instance.ref('mobile/uploads/$path/$customFileName');

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {
        'picked-file-path': file.path,
      },
    );

    final snapshot = await ref.putFile(file, metadata);
    if (snapshot.state != TaskState.success) {
      return null;
    }
    return snapshot.ref.getDownloadURL();
  }
}
