class NewMessages {
  final String name;
  final String description;
  final String image;
  const NewMessages(
      {required this.name, required this.description, required this.image});
}

List<NewMessages> newMessages = [
  const NewMessages(
      name: 'Khoa',
      description: 'Giáo viên dạy toán',
      image: 'assets/images/default-user.png'),
  const NewMessages(
      name: 'Tuấn',
      description: 'Giáo viên sinh học',
      image: 'assets/images/default-user.png'),
  const NewMessages(
      name: 'Hồng',
      description: 'Giáo viên thể dục',
      image: 'assets/images/default-user.png'),
  const NewMessages(
      name: 'Thi',
      description: 'Giáo viên GDCD',
      image: 'assets/images/default-user.png'),
];
