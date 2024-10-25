import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class StoreTokenUseCase {
  final DatabaseRepository repository;

  StoreTokenUseCase({required this.repository});

  Future<bool> call(int t_id) {
    return repository.storetoken(t_id);
  }
}
