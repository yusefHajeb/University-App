import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:university/core/widget/header_bar.dart';
import 'package:university/features/AllFeatures/domain/usecase/library_usecase/books_usecase.dart';
// import 'package:university/features/AllFeatures/presentation/bloc/services_bloc/services_bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/function/failure_to_message.dart';
import '../../../data/models/library_models/library_model.dart';
import '../../../domain/entites/header_books_entites.dart';
import '../../../domain/usecase/library_usecase/curse_usecase.dart';
import '../../../domain/usecase/library_usecase/library_usecase.dart';
part 'library_event.dart';
part 'library_state.dart';

late Either<Failure, Library> either;
late Either<Failure, List<Book>> bookEither;
late Either<Failure, List<Header>> courseEither;
List<Book> bookDown = [];

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final GetAllBooksUsecase getAllBooksUsecase;
  final GetBookUsecase getBookUsecase;
  final GetCoursesUsecase getCoursesUsecase;
  LibraryBloc(
      {required this.getAllBooksUsecase,
      required this.getBookUsecase,
      required this.getCoursesUsecase})
      : super(LibraryBooksInitial(index: 0)) {
    on<LibraryEvent>((event, emit) async {
      if (event is GetDataLibrary) {
        emit(LoadingLibraryState());
        bookEither = await getBookUsecase();
        courseEither = await getCoursesUsecase();
      }
      if (event is GetBooksLibraryEvent) {
        emit(LoadingLibraryState());
        either = await getAllBooksUsecase();
        emit(_failueOrHeaderState(either, 0));
      } else if (event is GetHeaderBooksLibraryEvent) {
        emit(LoadingLibraryState());
        emit(_failueOrHeaderState(either, event.index));
      }
      if (event is DownloadBookLibraryEvent) {
        downloadedBook.add(event.response);
      }
      if (event is DownloadBookLibraryEvent) {
        bookDown.add(event.response);
        emit(LibraryAddBookDownloadState(download: bookDown));
      }
    });
  }
  LibraryState _failueOrdownloadState(Either<Failure, Book> ether) {
    return ether.fold(
        (failure) => ErrorLibraryState(message: failureToMessage(failure)),
        (book) => LibraryBookDownloadState(bookDawonload: book));
  }

  LibraryState _failueOrGetAllBooksState(
      Either<Failure, Map<String, dynamic>> ether) {
    return ether.fold(
        (failure) => ErrorLibraryState(message: failureToMessage(failure)),
        (books) => LoadedBookLibraryState(books: books['book']));
  }

  LibraryState _failueOrHeaderState(Either<Failure, Library> ether, int index) {
    return ether.fold(
      (failure) => ErrorLibraryState(message: failureToMessage(failure)),
      (library) => HeaderBooksLibraryState(
        header: library.bookTitleModel,
        books: library.libraryModel,
        index: index,
      ),
    );
  }

  // LibraryState _failueOrLibraryState(Either<Failure, List<Book>> ether,
  //     Either<Failure, List<Header>> eitherHeader, int index) {
  //   // List<Book> book = [];
  //   // List<Header> header = [];
  //   return ether.fold(
  //       (failure) => ErrorFetchBooks(errorMessage: failureToMessage(failure)),
  //       (library) {
  //     eitherHeader.fold(
  //       (l) => ErrorFetchCourse(errorMessage: failureToMessage(l)),
  //       (r) {
  //         return LoadedHeaderLibraryState(header: r);
  //       },
  //     );
  //     return LoadedBookLibraryState(books: library);
  //   });
  // }
}

List<Book> downloadedBook = [];
