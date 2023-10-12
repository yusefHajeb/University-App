part of 'books_favorite_bloc.dart';

class BooksFavoriteEvent extends Equatable {
  const BooksFavoriteEvent();

  @override
  List<Object> get props => [];
}

class StartDownloadEvent extends BooksFavoriteEvent {
  final LibraryModel book;
  // List<BookDetaile> favorite = [];
  StartDownloadEvent({
    required this.book,
  });
}

class GetAllBooksDownloadEvent extends BooksFavoriteEvent {
  // final List<BookDetaile> favorite;
  // GetAllBooksDownloadEvent({required this.favorite});
}

class FavoritBookEvent extends BooksFavoriteEvent {}

class DeleteFavorites extends BooksFavoriteEvent {
  final int index;

  const DeleteFavorites({required this.index});
}
