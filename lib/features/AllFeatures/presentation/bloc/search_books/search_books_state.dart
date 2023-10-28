part of 'search_books_bloc.dart';

class SearchBooksState extends Equatable {
  final List<BookModel> books;
  SearchBooksState({required this.books});

  @override
  List<Object> get props => [books];
}
