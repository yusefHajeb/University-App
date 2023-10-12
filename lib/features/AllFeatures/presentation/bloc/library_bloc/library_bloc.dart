import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// import 'package:university/features/AllFeatures/presentation/bloc/services_bloc/services_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/function/failure_to_message.dart';
import '../../../data/models/library_models/library_model.dart';
import '../../../domain/entites/header_books_entites.dart';
import '../../../domain/usecase/library_usecase/library_usecase.dart';
part 'library_event.dart';
part 'library_state.dart';

late Either<Failure, Library> either;
List<BookDetaile> bookDown = [];

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final GetAllBooksUsecase getAllBooksUsecase;
  LibraryBloc({required this.getAllBooksUsecase})
      : super(LibraryBooksInitial(index: 0)) {
    on<LibraryEvent>((event, emit) async {
      // List<BookDetaile> bookDown = [];

      if (event is GetBooksLibraryEvent) {
        emit(LoadingLibraryState());
        either = await getAllBooksUsecase();
        emit(_failueOrHeaderState(either, 0));
      }
      if (event is GetHeaderBooksLibraryEvent) {
        emit(LoadingLibraryState());
        emit(_failueOrHeaderState(either, event.index));
      }
      if (event is DownloadBookLibraryEvent) {
        // var responsDownOrFailuer = await event.response;
        downloadedBook.add(event.response);
        // _failueOrdownloadState(responsDownOrFailuer);
      }
      if (event is DownloadBookLibraryEvent) {
        bookDown.add(event.response);
        emit(LibraryAddBookDownloadState(download: bookDown));
      }
    });
  }
  LibraryState _failueOrdownloadState(Either<Failure, BookDetaile> ether) {
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
}

List<BookDetaile> downloadedBook = [];
