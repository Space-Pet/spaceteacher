part of 'post_repository.dart';

const _postProp = '''id
name
url
featured_image_url
content_html
content
published_at
slug
name_en
content_html_en
url_en
content_en
''';

@Injectable(as: PostRepository)
class PostRepositoryImpl with DataRepository implements PostRepository {
  @override
  Future<List<Post>> getNewsPosts({required int limit, required int offset}) {
    const query = '''
      query GetNews(
        \$limit: Int, 
        \$offset: Int, 
        \$where: post_bool_exp
      ) {
        post(
          limit: \$limit,
          offset: \$offset,
          order_by: {published_at: desc}, 
          where: \$where,
        ) {
          $_postProp
        }
      }''';
    return graphqlProvider.queryList(
      query,
      Post.fromJson,
      'post',
      variables: {
        'limit': limit,
        'offset': offset,
        'where': {
          'published_at': {'_lte': 'now()'}
        }
      },
    ).then((value) => value ?? []);
  }

  @override
  Future<Post?> getPostDetail(String id) {
    const query = '''
      query GetNews(
        \$where: post_bool_exp
      ) {
        post(
          order_by: {published_at: asc}, 
          where: \$where,
        ) {
          $_postProp
        }
      }''';
    return graphqlProvider.queryList(
      query,
      Post.fromJson,
      'post',
      variables: {
        'where': {
          'id': {'_eq': id}
        }
      },
    ).then((value) => value?.first);
  }
}
