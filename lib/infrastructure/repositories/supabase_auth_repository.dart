import 'package:my_task_manager/domain/entities/app_user/app_user.dart';
import 'package:my_task_manager/domain/repositories/auth/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthRepository implements AuthRepository {
  final supabase = Supabase.instance.client;

  @override
  AppUser? get currentUser => _mapUserToAppUser(supabase.auth.currentUser);

  @override
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await supabase.auth.signUp(
        email: email,
        password: password,
      );
    } on AuthException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception('Failed to sign up');
    }
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception('Failed to sign in');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } on AuthException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception('Failed to sign out');
    }
  }

  @override
  Stream<AppUser?> onAuthStateChanged() {
    return supabase.auth.onAuthStateChange.map((event) {
      return _mapUserToAppUser(event.session?.user);
    });
  }

  AppUser? _mapUserToAppUser(User? user) {
    return user == null ? null : AppUser(id: user.id);
  }
}
