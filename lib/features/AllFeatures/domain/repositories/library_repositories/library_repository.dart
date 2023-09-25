import 'package:dartz/dartz.dart';
import 'package:university/features/AllFeatures/domain/entites/header_books_entites.dart';

import '../../../../../core/error/failure.dart';

abstract class LibraryRepository {
  Future<Either<Failure, List<BookDetaile>>> getALLBooks();
  Future<Either<Failure, BookDetaile>> getNotification();
}
