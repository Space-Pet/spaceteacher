class FaqInfo {
  final int status;
  final String title;
  final String text;
  FaqInfo({
    required this.status,
    required this.text,
    required this.title,
  });
  factory FaqInfo.fromMap(Map<String, dynamic> map){
    return FaqInfo(
        status: map['status'] ?? '',
        text: map['text'] ?? '',
        title: map['title'] ?? ''
    );
  }
}