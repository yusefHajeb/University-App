import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class IsSignInUseCase {
  final DatabaseRepository repository;

  IsSignInUseCase({required this.repository});

  Future<bool> call() async {
    return repository.isSignIn();
  }
}
