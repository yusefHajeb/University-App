import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/features/AllFeatures/data/models/library_models/library_model.dart';
import 'package:university/features/AllFeatures/domain/entites/header_books_entites.dart';
import '../../../../../core/constant/varibal.dart';
part 'books_favorite_event.dart';
part 'books_favorite_state.dart';

class DownloadBooksBloc extends Bloc<DownloadBooksEvent, DownlaodBooksState> {
  DownloadBooksBloc() : super((DownlaodBooksState(favrit: []))) {
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
      StartDownloadEvent event, Emitter<DownlaodBooksState> emit) async {
    print('-------------------------- bloc');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final decodeJsonData = sharedPreferences.getString(Constants.savedBooks);
    if (decodeJsonData != null) {
      List decodeBooks = json.decode(decodeJsonData);

      List<BookModel> localBook = decodeBooks
          .map<BookModel>((jsonData) => BookModel.formJson(jsonData))
          .toList();

      emit(BookDownloadState(favrit: localBook));
    }
  }

  Future<void> _deleteFavorites(
      DeleteFavorites event, Emitter<DownlaodBooksState> emit) async {
    List<Book> books = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final decodeJsonData = sharedPreferences.getString(Constants.savedBooks);
    if (decodeJsonData != null) {
      List decodeBooks = json.decode(decodeJsonData);

      List<BookModel> localBook = decodeBooks
          .map<BookModel>((jsonData) => BookModel.formJson(jsonData))
          .toList();
      for (var element in localBook) {
        if (element.tId != event.index) {
          books.add(element);
        }
      }
      await sharedPreferences.setString(
          Constants.savedBooks, json.encode(books));

      emit(BookDownloadState(favrit: books));
    }
    // state.favrit.forEach((element) {
    //   if (element.id != event.index) {
    //     books.add(element);
    //   }
    // });
    // emit(BookDownloadState(favrit: books));
  }
}
