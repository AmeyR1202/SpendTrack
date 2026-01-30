import 'package:expense_tracker/core/state/status.dart';
import 'package:expense_tracker/feature/expense/presentation/enter_name/bloc/enter_name_bloc.dart';
import 'package:expense_tracker/feature/expense/presentation/enter_name/bloc/enter_name_event.dart';
import 'package:expense_tracker/feature/expense/presentation/enter_name/bloc/enter_name_state.dart';
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
          context.go('/dashboard');
        }
        if (state.status == Status.error && state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Enter your name')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              BlocBuilder<EnterNameBloc, EnterNameState>(
                buildWhen: (previous, current) => previous.name != current.name,
                builder: (context, state) {
                  return TextField(
                    onChanged: (value) {
                      context.read<EnterNameBloc>().add(NameChanged(value));
                    },
                    decoration: const InputDecoration(labelText: 'Name'),
                  );
                },
              ),
              const SizedBox(height: 24),
              BlocBuilder<EnterNameBloc, EnterNameState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status,
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.status == Status.loading
                          ? null
                          : () {
                              context.read<EnterNameBloc>().add(SavePressed());
                            },
                      child: state.status == Status.loading
                          ? const CircularProgressIndicator()
                          : const Text('Continue'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
