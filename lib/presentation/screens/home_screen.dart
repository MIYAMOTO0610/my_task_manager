import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_task_manager/domain/repositories/auth/auth_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.read(authRepositoryProvider);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextButton(
                onPressed: () async => await repository.signOut(),
                child: const Text('ログアウト'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
