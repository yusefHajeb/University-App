// ignore_for_file: must_be_immutable

part of 'books_favorite_bloc.dart';

class DownlaodBooksState extends Equatable {
  List<BookDetaile> favrit;
  DownlaodBooksState({required this.favrit});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// class BooksFavoriteInitial extends BooksFavoriteState {}

class BookDownloadState extends DownlaodBooksState {
  bool isFavorite;

  BookDownloadState({this.isFavorite = false, required super.favrit});
  @override
  List<Object?> get props => [favrit, isFavorite];
}

class ShowAllBooksSavedState extends DownlaodBooksState {
  final List<BookDetaile> favorite;
  ShowAllBooksSavedState({required this.favorite, required super.favrit});

  @override
  List<Object> get props => [favorite];
}

class LoadingBookSatate extends DownlaodBooksState {
  LoadingBookSatate({required super.favrit});
}

class EmptyBooksState extends DownlaodBooksState {
  EmptyBooksState({required super.favrit});
}
