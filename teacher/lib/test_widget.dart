import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String text = """
    Đây là một đoạn văn bản dài khoảng 500 từ. Trong đoạn văn bản này có đề cập đến 2 từ "Giáo Viên".
    Giáo viên là một người có vai trò quan trọng trong việc giáo dục và đào tạo thế hệ trẻ.
    Giáo viên cần có kiến thức chuyên môn sâu rộng và kỹ năng giảng dạy tốt để truyền đạt kiến thức cho học sinh.
    """;

    // Thay thế tất cả các trường hợp xuất hiện của từ "Giáo Viên" bằng widget RichText

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Test Widget"),
        ),
        body: StatefulBuilder(builder: (context, state) {
          return boldStringWithKeyWord("Giáo Viên", text);
        }),
      ),
    );
  }

  RichText boldStringWithKeyWord(String keyWord, String source) {
    RegExp regex = RegExp(r'\b${keyWord}\b');
    Iterable<Match> matches = regex.allMatches(source);

    for (Match match in matches) {
      print(match.group(0));
    }

    return RichText(
      text: TextSpan(
        text: keyWord,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
