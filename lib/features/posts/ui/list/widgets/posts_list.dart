import 'package:code_quality_demo/core/ui/navigation/app_routes.dart';
import 'package:code_quality_demo/features/posts/ui/list/viewmodel.dart';
import 'package:code_quality_demo/features/posts/ui/list/widgets/post_item.dart';
import 'package:flutter/material.dart';

/// The list of posts display.
class PostsList extends StatelessWidget {
  /// The view model containing post data.
  final PostsViewModel viewModel;

  /// Creates a posts list widget.
  const PostsList({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return ListView.builder(
          itemCount: viewModel.posts.length,
          itemBuilder: (context, index) {
            final post = viewModel.posts[index];
            return PostItem(
              post: post,
              onTap: () => viewModel.navigateTo(
                AppRoutes.postDetails,
                arguments: {'id': index, 'title': post.title},
              ),
            );
          },
        );
      },
    );
  }
}
