import 'package:spend_wise/core/state/status.dart';
import 'package:spend_wise/core/theme/app_colors.dart';
import 'package:spend_wise/feature/expense/presentation/enter_name/bloc/enter_name_bloc.dart';
import 'package:spend_wise/feature/expense/presentation/enter_name/bloc/enter_name_event.dart';
import 'package:spend_wise/feature/expense/presentation/enter_name/bloc/enter_name_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EnterNameScreen extends StatelessWidget {
  const EnterNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EnterNameBloc, EnterNameState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == Status.success) {
          context.go('/opening-balance');
        }

        if (state.status == Status.error && state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Let us know what we should call you?',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 20),

                        BlocBuilder<EnterNameBloc, EnterNameState>(
                          buildWhen: (p, c) => p.name != c.name,
                          builder: (context, state) {
                            return TextField(
                              // autofocus: true,
                              onChanged: (value) {
                                context.read<EnterNameBloc>().add(
                                  NameChanged(value),
                                );
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter your name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(
                                      0,
                                      0,
                                      0,
                                      0.3,
                                    ), // enabled (not focused)
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(
                                      0,
                                      0,
                                      0,
                                      0.1,
                                    ), // focused
                                    width: 1,
                                  ),
                                ),
                              ),
                              cursorColor: AppColors.background,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                BlocBuilder<EnterNameBloc, EnterNameState>(
                  buildWhen: (p, c) => p.name != c.name,
                  builder: (context, state) {
                    final isEnabled = state.name.trim().isNotEmpty;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: isEnabled
                              ? () {
                                  context.read<EnterNameBloc>().add(
                                    SavePressed(),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isEnabled
                                ? AppColors.blue
                                : AppColors.background,
                            disabledBackgroundColor: const Color.fromARGB(
                              255,
                              0,
                              0,
                              0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
