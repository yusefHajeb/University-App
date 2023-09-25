import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:university/features/AllFeatures/domain/entites/header_books_entites.dart';

part 'books_favorite_event.dart';
part 'books_favorite_state.dart';

class BooksFavoriteBloc extends Bloc<BooksFavoriteEvent, BooksFavoriteState> {
  BooksFavoriteBloc() : super((BooksFavoriteState())) {
    on<BooksFavoriteEvent>((event, emit) {
      List<BookDetaile> favrit = [];
      if (event is StartDownloadEvent) {
        favrit.add(event.book);
        emit(BookDownloadState(book: event.book));
        // emit(ShowAllBooksSavedState(favorite: ));
      } else if (event is GetAllBooksDownloadEvent) {
        emit(LoadingBookSatate());
        emit(ShowAllBooksSavedState(favorite: favrit));
      }
    });
  }
}
