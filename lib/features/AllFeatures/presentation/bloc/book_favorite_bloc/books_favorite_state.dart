// ignore_for_file: must_be_immutable

part of 'books_favorite_bloc.dart';

class DownloadBooksState extends Equatable {
  List<Book> favrit;
  DownloadBooksState({required this.favrit});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// class BooksFavoriteInitial extends BooksFavoriteState {}

class BookDownloadState extends DownloadBooksState {
  bool isFavorite;

  BookDownloadState({this.isFavorite = false, required super.favrit});
  @override
  List<Object?> get props => [favrit, isFavorite];
}

class ShowAllBooksSavedState extends DownloadBooksState {
  final List<Book> favorite;
  ShowAllBooksSavedState({required this.favorite, required super.favrit});

  @override
  List<Object> get props => [favorite];
}

class LoadingDownloadBook extends DownloadBooksState {
  LoadingDownloadBook({required super.favrit});
}

class EmptyBooksState extends DownloadBooksState {
  EmptyBooksState({required super.favrit});
}
