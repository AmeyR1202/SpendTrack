import 'package:expense_tracker/core/state/status.dart';
import 'package:expense_tracker/feature/expense/presentation/splash/bloc/splash_bloc.dart';
import 'package:expense_tracker/feature/expense/presentation/splash/bloc/splash_event.dart';
import 'package:expense_tracker/feature/expense/presentation/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(SplashStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == Status.success) {
          if (state.isUserPresent) {
            context.go('/dashboard');
          } else {
            context.go('/enter-name');
          }
          if (state.status == Status.error) {
            // Optional: log or show fallback UI later
          }
        }
      },
      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
