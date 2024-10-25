import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class SignOutUseCase {
  final DatabaseRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call() async {
    return repository.signOut();
  }
}
