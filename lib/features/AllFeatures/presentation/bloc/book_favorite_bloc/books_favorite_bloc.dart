import 'package:bloc/bloc.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:equatable/equatable.dart';
import 'package:university/features/AllFeatures/data/models/library_models/library_model.dart';
import 'package:university/features/AllFeatures/domain/entites/header_books_entites.dart';

part 'books_favorite_event.dart';
part 'books_favorite_state.dart';

class BooksFavoriteBloc extends Bloc<BooksFavoriteEvent, BooksFavoriteState> {
  BooksFavoriteBloc() : super((BooksFavoriteState(favrit: []))) {
    on<StartDownloadEvent>(_booksFavoriteEvent);
    on<DeleteFavorites>(_deleteFavorites);
    // on<GetAllBooksDownloadEvent>(_showAllBooksSavedState);
    // if (event is StartDownloadEvent) {
    //   favrit.add(event.book);
    //   emit(BookDownloadState(book: event.book));
    //   // emit(ShowAllBooksSavedState(favorite: ));
    // } else if (event is GetAllBooksDownloadEvent) {
    //   emit(LoadingBookSatate());
    //   emit(ShowAllBooksSavedState(favorite: favrit));
    // }
  }

  Future<void> _booksFavoriteEvent(
      StartDownloadEvent event, Emitter<BooksFavoriteState> emit) async {
    List<BookDetaile> books = [];
    state.favrit.forEach((BookDetaile a) {
      books.add(a);
    });
    books.add(event.book);
    emit(BookDownloadState(favrit: books));
  }

  Future<void> _deleteFavorites(
      DeleteFavorites event, Emitter<BooksFavoriteState> emit) async {
    List<BookDetaile> books = [];
    state.favrit.forEach((element) {
      if (element.id != event.index) {
        books.add(element);
      }
    });
    emit(BookDownloadState(favrit: books));
  }
}
