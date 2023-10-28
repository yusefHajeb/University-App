part of 'library_bloc.dart';

class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object> get props => [];
}

class LibraryInitial extends LibraryEvent {}

class GetBooksLibraryEvent extends LibraryEvent {}

class GetDataLibrary extends LibraryEvent {}

class RefreshLibraryEvent extends LibraryEvent {}

// ignore: must_be_immutable
class GetHeaderBooksLibraryEvent extends LibraryEvent {
  int index;
  GetHeaderBooksLibraryEvent(this.index);
  @override
  List<Object> get props => [index];
}

class DownloadBookLibraryEvent extends LibraryEvent {
  final Book response;
  const DownloadBookLibraryEvent({
    required this.response,
  });

  @override
  List<Object> get props => [response];
}
