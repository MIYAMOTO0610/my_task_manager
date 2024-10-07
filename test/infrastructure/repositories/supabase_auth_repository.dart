import 'package:flutter_test/flutter_test.dart';
import 'package:my_task_manager/domain/repositories/auth/auth_repository.dart';
import 'package:my_task_manager/infrastructure/repositories/supabase_auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../test_helpers.dart';

void main() {
  // サインアウトしたあとにユーザを削除するため ID を保持する
  String? userId;

  setUpAll(() async {
    // SharedPreference はネイティブコードを使用してデータを扱うが
    // テスト環境ではプラットフォームチャネルが使用できないためモックを使用する
    SharedPreferences.setMockInitialValues({});

    await initializeSupabase();
  });

  tearDownAll(() async {
    await dotenv.load();
    final serviceRoleKey = dotenv.env['SUPABASE_SERVICE_ROLE_KEY'];
    if (serviceRoleKey == null) fail('SUPABASE_SERVICE_ROLE_KEY is not set');
    if (userId == null) fail('User is not signed in');
    await SupabaseClient(
            'https://kgadjovnnulfhsjdpolf.supabase.co', serviceRoleKey)
        .auth
        .admin
        .deleteUser(userId ?? '');
  });

  group('AuthService', () {
    late AuthRepository authRepository;

    setUp(() {
      authRepository = SupabaseAuthRepository();
    });

    test('ユーザがサインアップできる', () async {
      try {
        await authRepository.signUp(
          email: 'smiyamoto.610@gmail.com',
          password: 'password',
        );
        expect(authRepository.currentUser, isNotNull);
      } on Exception catch (error) {
        fail(error.toString());
      }
    });

    test('ユーザがサインインできる', () async {
      try {
        await authRepository.signIn(
          email: 'smiyamoto.610@gmail.com',
          password: 'password',
        );
        expect(authRepository.currentUser, isNotNull);
      } on Exception catch (error) {
        fail(error.toString());
      }
    });

    test('ユーザがサインアウトできる', () async {
      try {
        userId = authRepository.currentUser?.id;
        await authRepository.signOut();
        expect(authRepository.currentUser, null);
      } on Exception catch (error) {
        fail(error.toString());
      }
    });
  });
}
