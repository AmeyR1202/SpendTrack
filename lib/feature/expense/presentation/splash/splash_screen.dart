import 'package:spend_wise/core/state/status.dart';
import 'package:spend_wise/core/theme/app_colors.dart';
import 'package:spend_wise/feature/expense/presentation/splash/bloc/splash_bloc.dart';
import 'package:spend_wise/feature/expense/presentation/splash/bloc/splash_event.dart';
import 'package:spend_wise/feature/expense/presentation/splash/bloc/splash_state.dart';
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
            context.go('/');
          }
          if (state.status == Status.error) {
            // Optional: log or show fallback UI later
          }
        }
      },
      child: const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(flex: 3),

              Image(
                image: AssetImage('assets/icon/spend_wise.png'),
                width: 140,
              ),

              Spacer(flex: 2),

              SizedBox(
                width: 180,
                child: LinearProgressIndicator(minHeight: 3),
              ),

              Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
