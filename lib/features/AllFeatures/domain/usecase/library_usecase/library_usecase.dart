import 'package:dartz/dartz.dart';
import 'package:university/features/AllFeatures/data/models/library_models/library_model.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/library_repositories/library_repository.dart';

class GetAllBooksUsecase {
  final LibraryRepository rerpository;

  GetAllBooksUsecase({required this.rerpository});

  Future<Either<Failure, Library>> call() async {
    return await rerpository.getALLBooks();
  }
}
