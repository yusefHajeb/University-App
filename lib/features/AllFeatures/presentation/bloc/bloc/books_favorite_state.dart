part of 'books_favorite_bloc.dart';

class BooksFavoriteState extends Equatable {
  BooksFavoriteState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// class BooksFavoriteInitial extends BooksFavoriteState {}

class BookDownloadState extends BooksFavoriteState {
  final BookDetaile book;

  BookDownloadState({required this.book});
  @override
  // TODO: implement props
  List<Object?> get props => [book];
}

class ShowAllBooksSavedState extends BooksFavoriteState {
  final List<BookDetaile> favorite;
  ShowAllBooksSavedState({required this.favorite});

  @override
  List<Object> get props => [favorite];
}

class LoadingBookSatate extends BooksFavoriteState {}
