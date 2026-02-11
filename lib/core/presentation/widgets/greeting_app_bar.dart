import 'package:flutter/material.dart';

class GreetingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;

  const GreetingAppBar({super.key, required this.username});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 16,

        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Hi, ',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              TextSpan(
                text: username,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              TextSpan(
                text: '!',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            iconSize: 28,
            color: theme.colorScheme.onSurface,
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ],
      ),
    );
  }
}
