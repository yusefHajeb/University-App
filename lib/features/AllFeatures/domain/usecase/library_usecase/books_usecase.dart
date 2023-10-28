import 'package:dartz/dartz.dart';
import 'package:university/core/widget/header_bar.dart';
import 'package:university/features/AllFeatures/domain/entites/header_books_entites.dart';

import '../../../../../core/error/failure.dart';
import '../../repositories/library_repositories/library_repository.dart';

class GetBookUsecase {
  final LibraryRepository rerpository;

  GetBookUsecase({required this.rerpository});

  Future<Either<Failure, List<Book>>> call() async {
    return await rerpository.getBooks();
  }
}
