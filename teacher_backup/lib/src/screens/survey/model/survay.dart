class Survey {
  final String title;
  final List<String> questions;
  const Survey({required this.questions, required this.title});
}

final surveys = [
  const Survey(
    questions: [
      'Rất hài lòng',
      'Hài lòng',
      'Bình thường',
      'Không hài lòng',
      'Rất không hài lòng'
    ],
    title: 'Chương trình giáo dục của trường phong phú, đa dạng, phù hợp với sự phát triển toàn diện của học sinh.',
  ),
  const Survey(
    questions: [
      'Rất hài lòng',
      'Hài lòng',
      'Bình thường',
      'Không hài lòng',
      'Rất không hài lòng'
    ],
    title: 'Học sinh được quan tâm, chăm sóc và hỗ trợ kịp thời trong học tập và sinh hoạt',
  ),
  const Survey(
    questions: [
      'Rất hài lòng',
      'Hài lòng',
      'Bình thường',
      'Không hài lòng',
      'Rất không hài lòng'
    ],
    title: 'Học sinh được quan tâm, chăm sóc và hỗ trợ kịp thời trong học tập và sinh hoạt',
  ),
];
