import 'package:code_quality_demo/core/domain/models/ui_state.dart';
import 'package:code_quality_demo/core/resources/strings/app_strings.dart';
import 'package:code_quality_demo/core/ui/navigation/app_navigator.dart';
import 'package:code_quality_demo/core/ui/widgets/app_text/app_text.dart';
import 'package:code_quality_demo/features/posts/ui/list/viewmodel.dart';
import 'package:code_quality_demo/features/posts/ui/list/widgets/posts_app_bar.dart';
import 'package:code_quality_demo/features/posts/ui/list/widgets/posts_list.dart';
import 'package:flutter/material.dart';

/// The main screen displaying a list of posts.
class PostsScreen extends StatefulWidget {
  /// Creates the posts screen.
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final PostsViewModel _viewModel = PostsViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.loadPosts();
    _viewModel.uiState.addListener(_onUiStateChange);
    _viewModel.navigationRequest.addListener(_onNavigationRequest);
  }

  void _onNavigationRequest() {
    final request = _viewModel.navigationRequest.value;
    if (request == null) {
      return;
    }

    if (request.isPop) {
      AppNavigator.pop(request.arguments);
    } else if (request.isAndRemoveUntil) {
      AppNavigator.goHome();
    } else {
      AppNavigator.push(request.routeName!, arguments: request.arguments);
    }
  }

  void _onUiStateChange() {
    final state = _viewModel.uiState.value;
    if (state.isError) {
      _showDialog(AppStrings.error, state.message ?? '');
    } else if (state.isSuccess) {
      _showDialog(AppStrings.success, AppStrings.postsLoaded);
    }
  }

  void _showDialog(String title, String message) {
    if (!mounted) {
      return;
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: AppText(title),
        content: AppText(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const AppText(AppStrings.ok),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.uiState.removeListener(_onUiStateChange);
    _viewModel.navigationRequest.removeListener(_onNavigationRequest);
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PostsAppBar(),
      body: ValueListenableBuilder<UiState>(
        valueListenable: _viewModel.uiState,
        builder: (context, state, child) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return PostsList(viewModel: _viewModel);
        },
      ),
    );
  }
}
