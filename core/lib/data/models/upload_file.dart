import 'dart:io';

class UploadFile {
  final String name;
  final File file;

  UploadFile({required this.name, required this.file});

  factory UploadFile.fromJson(Map<String, dynamic> json) {
    return UploadFile(
      name: json['name'],
      file: json['file'],
    );
  }
}
