import 'package:code_quality_demo/core/resources/strings/app_strings.dart';
import 'package:code_quality_demo/core/ui/theme/theme_viewmodel.dart';
import 'package:code_quality_demo/core/ui/widgets/app_text/app_text.dart';
import 'package:code_quality_demo/features/auth/ui/auth_viewmodel.dart';
import 'package:flutter/material.dart';

/// The top app bar for the Posts screen.
class PostsAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates the posts app bar.
  const PostsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const AppText(AppStrings.appName),
      actions: [
        IconButton(
          icon: Icon(
            ThemeViewModel.instance.isDarkMode
                ? Icons.light_mode
                : Icons.dark_mode,
          ),
          onPressed: () => ThemeViewModel.instance.toggleTheme(),
        ),
        IconButton(
          tooltip: AppStrings.logout,
          icon: const Icon(Icons.logout),
          onPressed: () => AuthViewModel.instance.logout(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
