import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:my_task_manager/domain/repositories/auth/auth_repository.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isSignUp = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contexts) {
    final repository = ref.watch(authRepositoryProvider);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'メールアドレス'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'パスワード'),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      if (_isSignUp) {
                        await repository.signUp(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                      } else {
                        await repository.signIn(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                        ),
                      );
                    }
                  },
                  child: Text(_isSignUp ? '新規登録' : 'ログイン'),
                ),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: () {
                    setState(() => _isSignUp = !_isSignUp);
                  },
                  child: Text(
                    _isSignUp ? 'すでにアカウントをお持ちですか？' : 'アカウントをお持ちでない方はこちら',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
