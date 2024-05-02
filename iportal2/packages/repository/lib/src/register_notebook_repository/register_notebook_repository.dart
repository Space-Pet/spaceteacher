import 'package:core/data/models/models.dart';
import 'package:network_data_source/network_data_source.dart';

class RegisterNotebookRepository {
  RegisterNotebookRepository({
    required RegisterNoteBookApi registerNoteBookApi,
  }) : _registerNoteBook = registerNoteBookApi;

  final RegisterNoteBookApi _registerNoteBook;

  Future<WeeklyLessonData> getRegisterNoteBook() =>
      _registerNoteBook.getRegisterNoteBook();

  Future<ExerciseData> getExercise({
    required String userKey,
    required String txtDate,
  }) =>
      _registerNoteBook.getExercise(userKey, txtDate);

  Future<ScoreModel> getScore({
    required String userKey,
    required String txtTerm,
    required String txtYear,
  }) async {
    try {
      final scoreData =
          await _registerNoteBook.getScore(userKey, txtTerm, txtYear);
      return scoreData;
    } catch (e) {
      rethrow;
    }
  }
}
