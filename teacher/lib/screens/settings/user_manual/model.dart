class UserManual {
  final String id;
  final String title;
  final List<Content> content;
  const UserManual(
      {required this.content, required this.id, required this.title});
}

class Content {
  final String content;
  const Content({required this.content});
}

final List<UserManual> userManual = [
  const UserManual(content: [
    Content(
        content:
            'App Iportal UK Academy là ứng dụng học ngôn ngữ rất được ưa chuộng hiện nay, phù hợp với rất nhiều đối tượng.'),
    Content(
        content:
            'Với ứng dụng này, bạn sẽ tìm được một lộ trình học phù hợp với năng lực và mục tiêu của bản thân, được kiểm tra và rèn luyện năng lực Tiếng Anh qua những bài test hằng ngày.'),
    Content(
        content:
            'Khi bạn hoàn thành một kỹ năng hay vượt qua được một thử thách, App Iportal UK Academy sẽ tặng bạn tiền ảo để mua vật phẩm. Đó như là một món quà khích lệ tinh thần học tập.'),
  ], id: '01', title: 'Giới thiệu app iportal UK Academy'),
  const UserManual(content: [
    Content(
        content:
            'App Iportal UK Academy là ứng dụng học ngôn ngữ rất được ưa chuộng hiện nay, phù hợp với rất nhiều đối tượng.'),
    Content(
        content:
            'Với ứng dụng này, bạn sẽ tìm được một lộ trình học phù hợp với năng lực và mục tiêu của bản thân, được kiểm tra và rèn luyện năng lực Tiếng Anh qua những bài test hằng ngày.'),
    Content(
        content:
            'Khi bạn hoàn thành một kỹ năng hay vượt qua được một thử thách, App Iportal UK Academy sẽ tặng bạn tiền ảo để mua vật phẩm. Đó như là một món quà khích lệ tinh thần học tập.'),
  ], id: '02', title: 'Giới thiệu app iportal UK Academy'),
  const UserManual(content: [
    Content(
        content:
            'App Iportal UK Academy là ứng dụng học ngôn ngữ rất được ưa chuộng hiện nay, phù hợp với rất nhiều đối tượng.'),
    Content(
        content:
            'Với ứng dụng này, bạn sẽ tìm được một lộ trình học phù hợp với năng lực và mục tiêu của bản thân, được kiểm tra và rèn luyện năng lực Tiếng Anh qua những bài test hằng ngày.'),
    Content(
        content:
            'Khi bạn hoàn thành một kỹ năng hay vượt qua được một thử thách, App Iportal UK Academy sẽ tặng bạn tiền ảo để mua vật phẩm. Đó như là một món quà khích lệ tinh thần học tập.'),
  ], id: '03', title: 'Giới thiệu app iportal UK Academy'),
  const UserManual(content: [
    Content(
        content:
            'App Iportal UK Academy là ứng dụng học ngôn ngữ rất được ưa chuộng hiện nay, phù hợp với rất nhiều đối tượng.'),
    Content(
        content:
            'Với ứng dụng này, bạn sẽ tìm được một lộ trình học phù hợp với năng lực và mục tiêu của bản thân, được kiểm tra và rèn luyện năng lực Tiếng Anh qua những bài test hằng ngày.'),
    Content(
        content:
            'Khi bạn hoàn thành một kỹ năng hay vượt qua được một thử thách, App Iportal UK Academy sẽ tặng bạn tiền ảo để mua vật phẩm. Đó như là một món quà khích lệ tinh thần học tập.'),
  ], id: '04', title: 'Giới thiệu app iportal UK Academy'),
];
