class Title {
  final int id;
  final String content;
  final String titile;
  const Title({required this.content, required this.id, required this.titile});
}

final List<Title> title = [
  const Title(
      content: 'Có thể thực hiện nhiệm vụ/ hoạt động nhưng cần sự hỗ trợ',
      id: 1,
      titile: 'Đang hình thành'),
  const Title(
      content: 'Có thể thực hiện nhiệm vụ/ Hoạt động độc lập',
      id: 2,
      titile: 'Hình thành'),
  const Title(
      content: 'Xuất sắc hoàn thành nhiệm vụ/Hoạt động độc lập',
      id: 3,
      titile: 'Vượt trội')
];

class Content {
  final String title;
  final List<TitleReport> titleReport;
  const Content({required this.title, required this.titleReport});
}

class TitleReport {
  final String title;
  final List<ContentReport> contentReport;
  const TitleReport({required this.contentReport, required this.title});
}

class ContentReport {
  final int type;
  final String content;
  const ContentReport({required this.content, required this.type});
}

final List<Content> content = [
  const Content(
      title: 'Lĩnh vực phát triển thể chất và giác quan',
      titleReport: [
        TitleReport(contentReport: [
          ContentReport(content: 'Cân nặng theo tuổi', type: 1),
          ContentReport(
              content:
                  'Trẻ mạnh dạn tập thở nước và thả trôi theo hướng dẫn của giáo viên',
              type: 2),
          ContentReport(
              content:
                  'Giữ được thăng bằng cơ thể khi thực hiện các vận động: Đi thăng bằng trên ghẽ thể dục, đi kiểng gót, đứng co 1 chân',
              type: 1),
          ContentReport(
              content: 'Bò trườn theo hướng thăng, bò dích dắc trong đường hẹp',
              type: 3),
        ], title: 'A. Phát triển vận động thô và vận động tính')
      ]),
  const Content(
      title: 'Lĩnh vực phát triển thể chất và giác quan',
      titleReport: [
        TitleReport(contentReport: [
          ContentReport(content: 'Cân nặng theo tuổi', type: 1),
          ContentReport(
              content:
                  'Trẻ mạnh dạn tập thở nước và thả trôi theo hướng dẫn của giáo viên',
              type: 2),
          ContentReport(
              content:
                  'Giữ được thăng bằng cơ thể khi thực hiện các vận động: Đi thăng bằng trên ghẽ thể dục, đi kiểng gót, đứng co 1 chân',
              type: 1),
          ContentReport(
              content: 'Bò trườn theo hướng thăng, bò dích dắc trong đường hẹp',
              type: 3),
        ], title: 'A. Phát triển vận động thô và vận động tính')
      ]),
];
