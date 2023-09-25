
import 'package:dartz/dartz.dart';
import 'package:university/features/AllFeatures/domain/entites/header_books_entites.dart';

import '../../../../../core/error/failure.dart';
import '../../repositories/library_repositories/library_repository.dart';

class GetAllBooksUsecase  {
  final LibraryRepository rerpository;

  GetAllBooksUsecase({required this.rerpository});

  Future<Either<Failure, List<BookDetaile>>> call() async {
    return await rerpository.getALLBooks();
  }
}
