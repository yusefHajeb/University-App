import 'package:dartz/dartz.dart';
import 'package:university/core/widget/header_bar.dart';
import 'package:university/features/AllFeatures/domain/entites/header_books_entites.dart';

import '../../../../../core/error/failure.dart';
import '../../../data/models/library_models/library_model.dart';

abstract class LibraryRepository {
  Future<Either<Failure, Library>> getALLBooks();
  Future<Either<Failure, List<BookModel>>> getBooks();
  Future<Either<Failure, Book>> getNotification();
  Future<Either<Failure, List<Header>>> getCourse();
}
