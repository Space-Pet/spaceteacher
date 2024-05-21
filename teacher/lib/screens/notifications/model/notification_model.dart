enum NotiType {
  invoiceNoti,
  commonNoti,
  invoiceSuccess,
  checkinNoti,
}

class NotificationModel {
  final int id;
  final NotiType type;
  final String title;
  final String description;
  final bool isRead;
  final String dateTime;

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.isRead,
    required this.dateTime,
  });
}

final List<NotificationModel> notiList = [
  NotificationModel(
      id: 1,
      type: NotiType.invoiceNoti,
      title: 'Học phí tháng 02',
      description:
          'Số tiền còn phải nộp đợt thu Đợt 1 tháng 02/2024 của học sinh Nguyễn Ngọc Tuyết Lan (Mã học sinh 6xmpr5w2) là 790.000đ. Thời gian thu từ ngày 30/01/2024 đến ngày 10/02/2024.',
      isRead: false,
      dateTime: 'Thứ 7, 05/02/2024 - 9:42 AM'),
  NotificationModel(
      id: 2,
      type: NotiType.checkinNoti,
      title: 'Điểm danh Nguyễn Ngọc Tuyết Lan',
      description: 'Tiết 1 - Toán - Có mặt',
      isRead: true,
      dateTime: 'Thứ 7, 15/01/2024 - 9:42 AM'),
  NotificationModel(
      id: 3,
      type: NotiType.checkinNoti,
      title: 'Điểm danh Nguyễn Ngọc Tuyết Lan',
      description: 'Tiết 4 - Ngữ Văn - Vắng mặt',
      isRead: false,
      dateTime: 'Thứ 7, 15/01/2024 - 9:42 AM'),
  NotificationModel(
      id: 4,
      type: NotiType.commonNoti,
      title: 'Nguyễn Ngọc Tuyết Lan đã có mặt trên xe',
      description: 'Xe đang di chuyển đến trường',
      isRead: true,
      dateTime: 'Thứ 7, 15/01/2024 - 9:42 AM'),
  NotificationModel(
      id: 5,
      type: NotiType.invoiceSuccess,
      title: 'Xác nhận thanh toán thành công',
      description:
          'Học phí của Nguyễn Ngọc Tuyết Lan - lớp 6.1 đã được xác nhận đóng thành công.',
      isRead: true,
      dateTime: 'Thứ 7, 15/01/2024 - 9:42 AM'),
  NotificationModel(
      id: 6,
      type: NotiType.commonNoti,
      title: 'Sổ báo bài lớp 6.1 đã được cập nhật',
      description: 'Sổ báo bài  lớp 6.1 tuần 49 đã được cập nhật',
      isRead: true,
      dateTime: 'Thứ 7, 15/01/2024 - 9:42 AM'),
  NotificationModel(
      id: 7,
      type: NotiType.commonNoti,
      title: 'Lớp Mầm 2 đã có 1 abum mới',
      description: 'Album Hội thi vẽ đã được thêm trên thư viện',
      isRead: true,
      dateTime: 'Thứ 7, 15/01/2024 - 9:42 AM'),
  NotificationModel(
      id: 8,
      type: NotiType.invoiceSuccess,
      title: 'Xác nhận thanh toán thành công',
      description:
          'Học phí của Nguyễn Ngọc Tuyết Lan - lớp 6.1 đã được xác nhận đóng thành công.',
      isRead: true,
      dateTime: 'Thứ 7, 15/01/2024 - 9:42 AM'),
];
