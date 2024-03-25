import 'package:injectable/injectable.dart';

import '../../../../models/post.dart';
import '../../data_repository.dart';

part 'post_repository.impl.dart';

abstract class PostRepository {
  Future<List<Post>> getNewsPosts({required int limit, required int offset});
  Future<Post?> getPostDetail(String id);
}
