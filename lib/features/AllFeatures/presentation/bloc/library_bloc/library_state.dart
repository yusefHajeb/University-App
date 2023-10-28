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
  final List<Book> books;
  LoadedBookLibraryState({
    required this.books,
  });
  @override
  List<Object> get props => [books];
}

class LoadedHeaderLibraryState extends LibraryState {
  final List<Header> header;
  LoadedHeaderLibraryState({
    required this.header,
  });
  @override
  List<Object> get props => [header];
}

class LoadingLibraryState extends LibraryState {}

class HeaderBooksLibraryState extends LibraryState {
  final List<BookTitleModel> header;
  final int index;
  final List<BookModel> books;

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

class LibraryAddBookDownloadState extends LibraryState {
  final List<Book> download;
  LibraryAddBookDownloadState({required this.download});
  @override
  List<Object> get props => [download];
}

class LibraryBookDownloadState extends LibraryState {
  final Book bookDawonload;

  const LibraryBookDownloadState({required this.bookDawonload});
  @override
  List<Object> get props => [bookDawonload];
}
