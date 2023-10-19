part of 'books_favorite_bloc.dart';

class DownloadBooksEvent extends Equatable {
  const DownloadBooksEvent();

  @override
  List<Object> get props => [];
}

class StartDownloadEvent extends DownloadBooksEvent {
  // List<BookDetaile> favorite = [];
  StartDownloadEvent();
}

class GetAllBooksDownloadEvent extends DownloadBooksEvent {
  // final List<BookDetaile> favorite;
  // GetAllBooksDownloadEvent({required this.favorite});
}

class FavoritBookEvent extends DownloadBooksEvent {}

class DeleteFavorites extends DownloadBooksEvent {
  final int index;

  const DeleteFavorites({required this.index});
}
