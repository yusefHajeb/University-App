part of 'library_bloc.dart';

class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object> get props => [];
}

class LibraryInitial extends LibraryEvent {}

class GetBooksLibraryEvent extends LibraryEvent {}

class RefreshLibraryEvent extends LibraryEvent {}

class GetHeaderBooksLibraryEvent extends LibraryEvent {
  int index;
  GetHeaderBooksLibraryEvent(this.index);
  @override
  List<Object> get props => [index];
}
