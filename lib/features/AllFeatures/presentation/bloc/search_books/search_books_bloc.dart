import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:university/features/AllFeatures/data/datasource/library/library_local_data.dart';
import 'package:university/features/AllFeatures/data/models/library_models/library_model.dart';

part 'search_books_event.dart';
part 'search_books_state.dart';

class SearchBooksBloc extends Bloc<SearchBooksEvent, SearchBooksState> {
  LibraryLocalDataSource localDataSource;
  SearchBooksBloc(this.localDataSource) : super(SearchBooksState(books: [])) {
    on<SetVlaueSearched>(_setvalueSearched);
  }
  Future<void> _setvalueSearched(
    SetVlaueSearched event,
    Emitter<SearchBooksState> emit,
  ) async {
    print("====================xxxx ${event.value}");
    List<LibraryModel> books = localDataSource.getAllBooksCashed();
    if (books.isEmpty) {
      emit(SearchBooksState(books: []));
    } else {
      print(
          "===${books.where((element) => element.subject == event.value).toList()}");
      emit(SearchBooksState(
          books: books
              .where((element) => element.subject == event.value)
              .toList()));
    }
  }
}
