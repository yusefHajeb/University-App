import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class CountnumberNoseenUsecase {
  final DatabaseRepository repository;

  CountnumberNoseenUsecase({required this.repository});

  Future<int> call() async {
    return await repository.NumberMessagenotseen();
  }
}
