import 'package:expense_tracker/feature/expense/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) =>
          const SplashScreen(), // change to dashboard page later
    ),
    GoRoute(
      path: '/enter-name',
      builder: (context, state) => const PlaceholderPage(title: 'Enter Name'),
    ),
  ],
);

/// Temporary placeholder screens
class PlaceholderPage extends StatelessWidget {
  final String title;

  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title)),
    );
  }
}
