import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:university/core/constant/varibal.dart';
// import 'package:university/features/AllFeatures/presentation/bloc/services_bloc/services_bloc.dart';

import '../../../data/models/library_models/library_model.dart';
import '../../../domain/entites/books_entites.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  LibraryBloc() : super(LibraryBooksInitial(index: 0)) {
    on<LibraryEvent>((event, emit) {
      int cureent = 0;

      if (event is GetBooksLibraryEvent) {
        emit(LoadingLibraryState());

        emit(LoadedBookLibraryState(books: books));
      }
      if (event is GetHeaderBooksLibraryEvent) {
        emit(LoadingLibraryState());

        emit(HeaderBooksLibraryState(
            index: event.index, header: titles, books: books));

        // emit(LoadedBookLibraryState(books: books));
      }
    });
  }
}

// LibraryState _loadedOrErrorBooksState()

List<BookTitleModel> titles = [
  BookTitleModel(book_title: "NetWork", bookId: 1),
  BookTitleModel(book_title: "AI", bookId: 2),
  BookTitleModel(book_title: "OOP", bookId: 3),
  BookTitleModel(book_title: "web", bookId: 4),
  BookTitleModel(book_title: "OOP", bookId: 3),
  BookTitleModel(book_title: "web", bookId: 4),
  BookTitleModel(book_title: "OOP", bookId: 3),
  // BookTitleModel(book_title: "web", bookId: 4),
];

List<BookDetaile> books = const [
  BookDetaile(
      id: 2,
      category_id: 2,
      patch_id: 2,
      subject: "network",
      img_book: "assets/images/7.jpg",
      name_book: "Clean advanced",
      write_book: "Yousef Hajeb",
      pdfUrl: "pdfUrl"),
  BookDetaile(
      id: 2,
      category_id: 2,
      patch_id: 2,
      subject: "AI",
      img_book: "assets/images/5.jpg",
      name_book: "PHP form beginer to advanced",
      write_book: "Yousef Hajeb",
      pdfUrl: "pdfUrl"),
  BookDetaile(
      id: 2,
      category_id: 2,
      patch_id: 2,
      subject: "web",
      img_book: "assets/images/4.jpg",
      name_book: "ابي الجميل",
      write_book: "Yousef Hajeb",
      pdfUrl: "pdfUrl"),
  BookDetaile(
      id: 2,
      category_id: 2,
      patch_id: 2,
      subject: "network",
      img_book: "assets/images/2.jpg",
      name_book: "Network form begnersn to advanced",
      write_book: "Yousef Hajeb",
      pdfUrl: "pdfUrl"),
  BookDetaile(
      id: 2,
      category_id: 2,
      patch_id: 2,
      subject: "network",
      img_book: "assets/images/2.jpg",
      name_book: "Network form begnersn to advanced",
      write_book: "Yousef Hajeb",
      pdfUrl: "pdfUrl"),
];

double changePostionedLine(int index, BuildContext ctx, int linght) {
  int size = (appSize(ctx).width / linght).toInt();
  // switch (index) {
  //   case 2:
  //     return (size *2  ).toDouble();

  //   case 2:
  //     return (appSize(ctx).width / 2).toDouble();
  //   case 3:
  //     return (appSize(ctx).width / 3).toDouble();
  //   case 4:
  //     return (appSize(ctx).width / 4).toDouble();
  //   default:
  //     return 0;
  // }
  return size > 5
      ? (size * index - 5).toDouble()
      : (size * index - linght).toDouble();
}
