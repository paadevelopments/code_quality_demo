import 'package:code_quality_demo/features/posts/data/models/post.dart';

/// Feature-specific extensions for the Post model.
extension PostExtensions on Post {
  String get shortBody {
    if (body.length > 50) {
      return "${body.substring(0, 50)}...";
    }
    return body;
  }
}
