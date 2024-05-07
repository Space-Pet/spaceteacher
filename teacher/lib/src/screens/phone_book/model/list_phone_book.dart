import 'package:core/data/models/models.dart';
import 'package:core/data/models/phone_book_teacher.dart';

class PhoneBook {
  final String name;
  final String id;
  final String image;
  PhoneBook({required this.id, required this.image, required this.name});
}

final List<PhoneBookStudent> phoneBook = [
  const PhoneBookStudent(
      classId: 123456,
      fullName: 'Hạ Trang',
      pupilId: 456789,
      className: '6.1',
      urlImage: UrlImagePhoneBook(
          mobile: 'assets/images/image-phone-book.png', web: 'web'),
      userId: '789',
      userKey: 'userKey'),
  // PhoneBook(
  //     id: 'MHS1123456',
  //     image: 'assets/images/image-phone-book.png',
  //     name: 'Hà Anh Minh'),
  // PhoneBook(
  //     id: 'MHS1123456',
  //     image: 'assets/images/image-phone-book.png',
  //     name: 'Hạ Trang'),
  // PhoneBook(
  //     id: 'MHS1123456',
  //     image: 'assets/images/image-phone-book.png',
  //     name: 'Nguyễn Trung Quân'),
  // PhoneBook(
  //     id: 'MHS1123456',
  //     image: 'assets/images/image-phone-book.png',
  //     name: 'Đinh Thuỳ Linh'),
  // PhoneBook(
  //     id: 'MHS1123456',
  //     image: 'assets/images/image-phone-book.png',
  //     name: 'Nghiêm Ngọc Trân'),
  // PhoneBook(
  //     id: 'MHS1123456',
  //     image: 'assets/images/image-phone-book.png',
  //     name: 'Hà Nguyễn'),
  // PhoneBook(
  //     id: 'MHS1123456',
  //     image: 'assets/images/image-phone-book.png',
  //     name: 'Hoàng Anh'),
  // PhoneBook(
  //     id: 'MHS1123456',
  //     image: 'assets/images/image-phone-book.png',
  //     name: 'Thị Nhi'),
  // PhoneBook(
  //     id: 'MHS1123456',
  //     image: 'assets/images/image-phone-book.png',
  //     name: 'Đinh Quốc thái'),
];

final List<PhoneBookTeacher> phoneBookTeacher = [
  const PhoneBookTeacher(
      fullName: 'Hà Anh Minh',
      mainSubject: 'Tieng Anh',
      schoolId: 104,
      schoolName: 'ischool',
      teacherId: 123456,
      urlImageTeacher:
          UrlImageTeacher(mobile: 'assets/images/image-teacher.png', web: ''),
      userId: '4567',
      userKey: ' userKey')
  // PhoneBook(
  //     id: 'MHS1123456',
  //     image: 'assets/images/image-teacher.png',
  //     name: 'Hạ Trang'),
  // PhoneBook(
  //     id: 'MHS1123456',
  //     image: 'assets/images/image-teacher.png',
  //     name: 'Nguyễn Trung Quân'),
  // PhoneBook(
  //     id: 'MHS1123456',
  //     image: 'assets/images/image-teacher.png',
  //     name: 'Đinh Thuỳ Linh'),
  // PhoneBook(
  //     id: 'MHS1123456',
  //     image: 'assets/images/image-teacher.png',
  //     name: 'Nghiêm Ngọc Trân'),
  // PhoneBook(
  //     id: 'MHS1123456',
  //     image: 'assets/images/image-teacher.png',
  //     name: 'Hà Nguyễn'),
  // PhoneBook(
  //     id: 'MHS1123456',
  //     image: 'assets/images/image-teacher.png',
  //     name: 'Hoàng Anh'),
  // PhoneBook(
  //     id: 'MHS1123456',
  //     image: 'assets/images/image-teacher.png',
  //     name: 'Thị Nhi'),
  // PhoneBook(
  //     id: 'MHS1123456',
  //     image: 'assets/images/image-teacher.png',
  //     name: 'Đinh Quốc thái'),
];
