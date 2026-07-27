import 'package:code_quality_demo/core/ui/widgets/app_text/app_text.dart';
import 'package:code_quality_demo/features/posts/data/models/post.dart';
import 'package:code_quality_demo/features/posts/domain/extensions/post_extensions.dart';
import 'package:flutter/material.dart';

/// A single list item representing a post.
class PostItem extends StatelessWidget {
  /// The post data.
  final Post post;

  /// Callback when the item is tapped.
  final VoidCallback onTap;

  /// Creates a post list item.
  const PostItem({super.key, required this.post, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: AppText(
        post.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: AppText(post.shortBody),
      onTap: onTap,
    );
  }
}
