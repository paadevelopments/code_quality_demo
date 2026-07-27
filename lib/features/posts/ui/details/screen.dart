import 'package:code_quality_demo/core/resources/strings/app_strings.dart';
import 'package:code_quality_demo/core/ui/widgets/app_text/app_text.dart';
import 'package:flutter/material.dart';

/// Screen displaying the details of a specific post.
class PostDetailsScreen extends StatelessWidget {
  /// Navigation arguments containing post details.
  final Map<String, dynamic>? arguments;

  /// Creates a post details screen.
  const PostDetailsScreen({super.key, this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppText(arguments?['title'] ?? 'Details')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText('Post ID: ${arguments?['id']}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(AppStrings.liked),
              child: const AppText(AppStrings.likeAndReturn),
            ),
          ],
        ),
      ),
    );
  }
}
