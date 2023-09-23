part of 'library_bloc.dart';

class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class LibraryBooksInitial extends LibraryState {
  int index;
  LibraryBooksInitial({required this.index});
}

class LoadedBookLibraryState extends LibraryState {
  final List<BookDetaile> books;

  LoadedBookLibraryState({
    required this.books,
  });

  @override
  List<Object> get props => [books];
}

class LoadingLibraryState extends LibraryState {}

class HeaderBooksLibraryState extends LibraryState {
  final List<BookTitleModel> header;
  final int index;
  final List<BookDetaile> books;

  HeaderBooksLibraryState(
      {required this.index, required this.header, required this.books});

  @override
  List<Object> get props => [header, index, books];
}

class ErrorLibraryState extends LibraryState {
  final String message;

  const ErrorLibraryState({required this.message});

  @override
  List<Object> get props => [message];
}
