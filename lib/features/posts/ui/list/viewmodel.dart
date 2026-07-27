import 'package:code_quality_demo/core/ui/base_viewmodel.dart';
import 'package:code_quality_demo/features/posts/data/models/post.dart';
import 'package:code_quality_demo/features/posts/data/repositories/posts_repository.dart';

/// ViewModel for managing the state of the posts list.
class PostsViewModel extends BaseViewModel {
  final PostsRepository _repository = PostsRepository();

  /// The list of posts.
  List<Post> posts = [];

  /// Loads the posts.
  Future<void> loadPosts({Map<String, String>? additionalHeaders}) async {
    setLoading();
    try {
      posts = await _repository.getPosts(
        additionalHeaders: additionalHeaders,
      );
      setSuccess(posts);
    } catch (e) {
      setError(e.toString());
    }
    refresh();
  }
}
