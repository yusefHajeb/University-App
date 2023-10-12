part of 'books_favorite_bloc.dart';

class BooksFavoriteState extends Equatable {
  List<BookDetaile> favrit;
  BooksFavoriteState({required this.favrit});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// class BooksFavoriteInitial extends BooksFavoriteState {}

class BookDownloadState extends BooksFavoriteState {
  bool isFavorite;

  BookDownloadState({this.isFavorite = false, required super.favrit});
  @override
  List<Object?> get props => [favrit, isFavorite];
}

class ShowAllBooksSavedState extends BooksFavoriteState {
  final List<BookDetaile> favorite;
  ShowAllBooksSavedState({required this.favorite, required super.favrit});

  @override
  List<Object> get props => [favorite];
}

class LoadingBookSatate extends BooksFavoriteState {
   LoadingBookSatate({required super.favrit});
}
