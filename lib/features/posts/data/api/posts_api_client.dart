import 'package:code_quality_demo/core/data/api/base_api_client.dart';
import 'package:code_quality_demo/features/posts/data/api/posts_api_paths.dart';
import 'package:code_quality_demo/features/posts/data/models/post_response.dart';

/// Client for fetching post-related data.
class PostsApiClient extends BaseApiClient {
  final PostsApiPaths _paths = PostsApiPaths();

  /// Retrieves a list of posts from the server.
  Future<List<PostResponse>> getPosts({
    Map<String, String>? additionalHeaders,
  }) async {
    final response = await get(
      _paths.posts,
      additionalHeaders: additionalHeaders,
    );
    return (response as List)
        .map((json) => PostResponse.fromJson(json))
        .toList();
  }
}
