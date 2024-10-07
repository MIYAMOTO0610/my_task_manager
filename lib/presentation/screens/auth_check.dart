import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_task_manager/application/providers/auth_provider.dart';
import 'package:my_task_manager/presentation/screens/home_screen.dart';
import 'package:my_task_manager/presentation/screens/login_screen.dart';

class AuthCheck extends ConsumerWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateAsync = ref.watch(authStateProvider);

    return authStateAsync.when(
      data: (user) {
        if (user == null) return const LoginScreen();
        return const HomeScreen();
      },
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => const Text('Error'),
    );
  }
}
