part of 'search_books_bloc.dart';

sealed class SearchBooksEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SetVlaueSearched extends SearchBooksEvent {
  final String value;

  SetVlaueSearched({required this.value});
}
