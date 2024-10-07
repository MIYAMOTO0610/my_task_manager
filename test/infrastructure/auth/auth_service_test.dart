import 'package:flutter_test/flutter_test.dart';
import 'package:my_task_manager/infrastructure/auth/auth_service.dart';
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
    late AuthService authService;

    setUp(() {
      authService = AuthService();
    });

    test('ユーザがサインアップできる', () async {
      try {
        await authService.signUp('smiyamoto.610@gmail.com', 'password');
        expect(authService.currentUser?.email, 'smiyamoto.610@gmail.com');
      } on Exception catch (error) {
        fail(error.toString());
      }
    });

    test('ユーザがサインインできる', () async {
      try {
        await authService.signIn('smiyamoto.610@gmail.com', 'password');
        expect(authService.currentUser?.email, 'smiyamoto.610@gmail.com');
      } on Exception catch (error) {
        fail(error.toString());
      }
    });

    test('ユーザがサインアウトできる', () async {
      try {
        userId = authService.currentUser?.id;
        await authService.signOut();
        expect(authService.currentUser, null);
      } on Exception catch (error) {
        fail(error.toString());
      }
    });
  });
}
