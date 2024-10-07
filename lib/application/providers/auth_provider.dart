import 'package:my_task_manager/domain/entities/app_user/app_user.dart';
import 'package:my_task_manager/domain/repositories/auth/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<AppUser?> authState(AuthStateRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.onAuthStateChanged();
}
