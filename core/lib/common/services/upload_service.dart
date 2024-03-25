import 'dart:io';

abstract class UploadService {
  static const userProfilePath = 'user-profile';
  static const registerteacher = 'register-teacher';
  static const bookingPartnerAssistant = 'booking-partner-assistant';
  static const bookingCheckIn = 'booking-check-in';
  static const bookingChat = 'booking-chat';
  static const judicialFiles = 'judical-files';
  static const conductRecords = 'conduct-records';

  Future<String?> uploadImage(File file, String fileName, String path);
}

