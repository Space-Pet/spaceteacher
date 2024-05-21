
class Faq {
  final String id;
  final String title;
  final List<Question> question;
  const Faq({required this.id, required this.question, required this.title});
}

class Question {
  final String question;
  final List<ContentQuestion> content;
  const Question({required this.content, required this.question});
}

class ContentQuestion {
  final String content;
  const ContentQuestion({required this.content});
}

final faq = [
  const Faq(
      id: '01',
      question: [
        Question(content: [
          ContentQuestion(
              content:
                  'Chương trình dạy học theo chuẩn đầu ra hướng đến sự phát triển toàn diện và hài hòa cùng với trải nghiệm học tập và thang đo đánh giá lấy trẻ làm trung tâm.'),
          ContentQuestion(
              content:
                  'Chương trình giáo dục Mầm non UK Academy được thiết kế theo định hướng giáo dục dựa trên năng lực, giúp trẻ phát triển toàn diện hài hòa giữa thể chất, trí tuệ, tinh thần, phẩm chất và mối quan hệ xã hội. Chương trình được thiết kế dựa trên khung Chương trình Giáo dục Mầm non Anh Quốc (EYFS); đảm bảo sự phát triển cân bằng cho trẻ với 7 lĩnh vực học tập bao gồm: Giao tiếp & Ngôn ngữ, Phát triển Thể chất, Kỹ năng đọc viết, Toán học, Hiểu về Thế giới, Nghệ thuật biểu đạt & Thiết kế, Phát triển Cá nhân và Cảm xúc – Xã hội; chú trọng phát triển năng lực tư duy, kích thích trí tò mò, tư duy đa chiều và sáng tạo cho trẻ.'),
          ContentQuestion(
              content:
                  'Phát triển Cá nhân và Cảm xúc – Xã hội được phát triển mở rộng dựa trên khung năng lực của CASEL (Tổ chức dẫn đầu phong trào năng lực Cảm xúc – Xã hội); trang bị cho trẻ kỹ năng sống, khả năng nhận thức và quản lý cảm xúc, nhận diện các hành vi phù hợp, biết tôn trọng, hợp tác và quan tâm đến mọi người xung quanh, v.v.')
        ], question: 'Chương trình đào tạo của UK Academy có gì ưu việt?'),
        Question(content: [
          ContentQuestion(
              content:
                  'Chương trình dạy học theo chuẩn đầu ra hướng đến sự phát triển toàn diện và hài hòa cùng với trải nghiệm học tập và thang đo đánh giá lấy trẻ làm trung tâm.'),
          ContentQuestion(
              content:
                  'Chương trình giáo dục Mầm non UK Academy được thiết kế theo định hướng giáo dục dựa trên năng lực, giúp trẻ phát triển toàn diện hài hòa giữa thể chất, trí tuệ, tinh thần, phẩm chất và mối quan hệ xã hội. Chương trình được thiết kế dựa trên khung Chương trình Giáo dục Mầm non Anh Quốc (EYFS); đảm bảo sự phát triển cân bằng cho trẻ với 7 lĩnh vực học tập bao gồm: Giao tiếp & Ngôn ngữ, Phát triển Thể chất, Kỹ năng đọc viết, Toán học, Hiểu về Thế giới, Nghệ thuật biểu đạt & Thiết kế, Phát triển Cá nhân và Cảm xúc – Xã hội; chú trọng phát triển năng lực tư duy, kích thích trí tò mò, tư duy đa chiều và sáng tạo cho trẻ.'),
          ContentQuestion(
              content:
                  'Phát triển Cá nhân và Cảm xúc – Xã hội được phát triển mở rộng dựa trên khung năng lực của CASEL (Tổ chức dẫn đầu phong trào năng lực Cảm xúc – Xã hội); trang bị cho trẻ kỹ năng sống, khả năng nhận thức và quản lý cảm xúc, nhận diện các hành vi phù hợp, biết tôn trọng, hợp tác và quan tâm đến mọi người xung quanh, v.v.')
        ], question: 'Chương trình đào tạo của UK Academy có gì ưu việt?'),
        Question(content: [
          ContentQuestion(
              content:
                  'Chương trình dạy học theo chuẩn đầu ra hướng đến sự phát triển toàn diện và hài hòa cùng với trải nghiệm học tập và thang đo đánh giá lấy trẻ làm trung tâm.'),
          ContentQuestion(
              content:
                  'Chương trình giáo dục Mầm non UK Academy được thiết kế theo định hướng giáo dục dựa trên năng lực, giúp trẻ phát triển toàn diện hài hòa giữa thể chất, trí tuệ, tinh thần, phẩm chất và mối quan hệ xã hội. Chương trình được thiết kế dựa trên khung Chương trình Giáo dục Mầm non Anh Quốc (EYFS); đảm bảo sự phát triển cân bằng cho trẻ với 7 lĩnh vực học tập bao gồm: Giao tiếp & Ngôn ngữ, Phát triển Thể chất, Kỹ năng đọc viết, Toán học, Hiểu về Thế giới, Nghệ thuật biểu đạt & Thiết kế, Phát triển Cá nhân và Cảm xúc – Xã hội; chú trọng phát triển năng lực tư duy, kích thích trí tò mò, tư duy đa chiều và sáng tạo cho trẻ.'),
          ContentQuestion(
              content:
                  'Phát triển Cá nhân và Cảm xúc – Xã hội được phát triển mở rộng dựa trên khung năng lực của CASEL (Tổ chức dẫn đầu phong trào năng lực Cảm xúc – Xã hội); trang bị cho trẻ kỹ năng sống, khả năng nhận thức và quản lý cảm xúc, nhận diện các hành vi phù hợp, biết tôn trọng, hợp tác và quan tâm đến mọi người xung quanh, v.v.')
        ], question: 'Chương trình đào tạo của UK Academy có gì ưu việt?')
      ],
      title: 'Thông tin chung'),
  const Faq(
      id: '02',
      question: [
        Question(content: [
          ContentQuestion(
              content:
                  'Chương trình dạy học theo chuẩn đầu ra hướng đến sự phát triển toàn diện và hài hòa cùng với trải nghiệm học tập và thang đo đánh giá lấy trẻ làm trung tâm.'),
          ContentQuestion(
              content:
                  'Chương trình giáo dục Mầm non UK Academy được thiết kế theo định hướng giáo dục dựa trên năng lực, giúp trẻ phát triển toàn diện hài hòa giữa thể chất, trí tuệ, tinh thần, phẩm chất và mối quan hệ xã hội. Chương trình được thiết kế dựa trên khung Chương trình Giáo dục Mầm non Anh Quốc (EYFS); đảm bảo sự phát triển cân bằng cho trẻ với 7 lĩnh vực học tập bao gồm: Giao tiếp & Ngôn ngữ, Phát triển Thể chất, Kỹ năng đọc viết, Toán học, Hiểu về Thế giới, Nghệ thuật biểu đạt & Thiết kế, Phát triển Cá nhân và Cảm xúc – Xã hội; chú trọng phát triển năng lực tư duy, kích thích trí tò mò, tư duy đa chiều và sáng tạo cho trẻ.'),
          ContentQuestion(
              content:
                  'Phát triển Cá nhân và Cảm xúc – Xã hội được phát triển mở rộng dựa trên khung năng lực của CASEL (Tổ chức dẫn đầu phong trào năng lực Cảm xúc – Xã hội); trang bị cho trẻ kỹ năng sống, khả năng nhận thức và quản lý cảm xúc, nhận diện các hành vi phù hợp, biết tôn trọng, hợp tác và quan tâm đến mọi người xung quanh, v.v.')
        ], question: 'Chương trình đào tạo của UK Academy có gì ưu việt?')
      ],
      title: 'Trương trình đào tạo'),
];
