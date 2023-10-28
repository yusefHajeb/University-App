import 'package:dartz/dartz.dart';

import 'package:university/core/error/failure.dart';
import 'package:university/core/widget/header_bar.dart';
import 'package:university/features/AllFeatures/data/datasource/library/library_local_data.dart';
import 'package:university/features/AllFeatures/data/datasource/library/library_remote_data.dart';
import 'package:university/features/AllFeatures/data/models/library_models/library_model.dart';
import 'package:university/features/AllFeatures/domain/entites/header_books_entites.dart';
import 'package:university/main.dart';
import '../../../../../core/error/execptions.dart';
import '../../../../../core/network/check_network.dart';
import '../../../domain/repositories/library_repositories/library_repository.dart';

class LibraryRepositoryImp implements LibraryRepository {
  final LibraryRemoteDataSource remoteDataSource;
  final LibraryLocalDataSource localSource;
  final NetworkInfo networkInfo;

  LibraryRepositoryImp(
      {required this.remoteDataSource,
      required this.localSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, Library>> getALLBooks() async {
    if (await socket.connected) {
      try {
        var dataRespnse = await remoteDataSource.getAllBooks();
        print(dataRespnse);
        final List<BookModel> remoteData = dataRespnse.libraryModel;
        localSource.cachBooks(remoteData);
        localSource.cachHeadersBooks(dataRespnse.bookTitleModel);
        return Right(Library(
            libraryModel: dataRespnse.libraryModel,
            bookTitleModel: dataRespnse.bookTitleModel));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        print("no Internet Connection ==========");
        // var local = await localSource.getCashedBook();
        var localData = await localSource.getCashedBook();
        print(
            "${localData.bookTitleModel} ============== ${localData.libraryModel}");
        return Right(Library(
            libraryModel: localData.libraryModel,
            bookTitleModel: localData.bookTitleModel));
      } on EmptyCasheException {
        return Left(EmptyCasheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Book>> getNotification() {
    // TODO: implement getNotification
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<BookModel>>> getBooks() async {
    if (await networkInfo.isConnected) {
      try {
        final List<BookModel> dataRespnse = await remoteDataSource.getBooks();
        print(dataRespnse);
        final List<BookModel> remoteData = dataRespnse;
        localSource.cachBooks(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Right(localSource.getAllBooksCashed());
    }
  }

  @override
  Future<Either<Failure, List<Header>>> getCourse() {
    throw UnimplementedError();
  }
}
