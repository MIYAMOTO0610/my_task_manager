import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:my_task_manager/domain/entities/app_user/app_user.dart';
import 'package:my_task_manager/infrastructure/repositories/supabase_auth_repository.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return SupabaseAuthRepository();
}

abstract class AuthRepository {
  AppUser? get currentUser;
  Future<void> signUp({required String email, required String password});
  Future<void> signIn({required String email, required String password});
  Future<void> signOut();
  Stream<AppUser?> onAuthStateChanged();
}
