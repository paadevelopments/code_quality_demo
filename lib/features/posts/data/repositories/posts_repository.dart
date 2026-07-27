import 'package:code_quality_demo/core/data/repositories/base_repository.dart';
import 'package:code_quality_demo/features/posts/data/api/posts_api_client.dart';
import 'package:code_quality_demo/features/posts/data/models/post.dart';

/// Repository responsible for post data operations.
class PostsRepository extends BaseRepository {
  final PostsApiClient _apiClient = PostsApiClient();

  /// Fetches posts and transforms them into domain models.
  Future<List<Post>> getPosts({Map<String, String>? additionalHeaders}) {
    return execute(() async {
      final responses = await _apiClient.getPosts(
        additionalHeaders: additionalHeaders,
      );
      return responses.map((r) => Post(title: r.title, body: r.body)).toList();
    });
  }
}
