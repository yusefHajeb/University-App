import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class ForgotPasswordUseCase {
  final DatabaseRepository repository;

  ForgotPasswordUseCase({required this.repository});

  Future<void> call(String email) {
    return repository.forgotPassword(email);
  }
}
