import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/features/AllFeatures/data/datasource/library/library_local_data.dart';
// import 'package:university/features/AllFeatures/presentation/bloc/services_bloc/services_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/function/failure_to_message.dart';
import '../../../data/models/library_models/library_model.dart';
import '../../../domain/entites/header_books_entites.dart';
import '../../../domain/usecase/library_usecase/library_usecase.dart';
part 'library_event.dart';
part 'library_state.dart';

late Either<Failure, Library> either;

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final GetAllBooksUsecase getAllBooksUsecase;
  LibraryBloc({required this.getAllBooksUsecase})
      : super(LibraryBooksInitial(index: 0)) {
    on<LibraryEvent>((event, emit) async {
      List<BookDetaile> bookDown = [];

      if (event is GetBooksLibraryEvent) {
        emit(LoadingLibraryState());
        either = await getAllBooksUsecase();
        emit(_failueOrHeaderState(either, 0));
      }
      if (event is GetHeaderBooksLibraryEvent) {
        emit(LoadingLibraryState());
        emit(_failueOrHeaderState(either, event.index));
      }
      if (event is DownloadBookLibraryEvent) {
        var responsDownOrFailuer = await event.response;
        _failueOrdownloadState(responsDownOrFailuer);
      }
    });
  }
  LibraryState _failueOrdownloadState(Either<Failure, BookDetaile> ether) {
    return ether.fold(
        (failure) => ErrorLibraryState(message: failureToMessage(failure)),
        (book) => LibraryBookDownloadState(bookDawonload: book));
  }

  LibraryState _failueOrGetAllBooksState(
      Either<Failure, Map<String, dynamic>> ether) {
    return ether.fold(
        (failure) => ErrorLibraryState(message: failureToMessage(failure)),
        (books) => LoadedBookLibraryState(books: books['book']));
  }

  LibraryState _failueOrHeaderState(Either<Failure, Library> ether, int index) {
    return ether.fold(
        (failure) => ErrorLibraryState(message: failureToMessage(failure)),
        (library) => HeaderBooksLibraryState(
              header: library.bookTitleModel,
              books: library.libraryModel,
              index: index,
            ));
  }
}

// LibraryState _loadedOrErrorBooksState()
List<BookDetaile> getBooksByOpenPage(int page) {
  List<BookDetaile> allBooks = books;
  return allBooks.where((book) => book.patch_id! >= page).toList();
}

List<BookTitleModel> titles = [
  BookTitleModel(book_title: "الكل", bookId: 1),
  BookTitleModel(book_title: "شبكات", bookId: 2),
  BookTitleModel(book_title: "نطبيقات ذكاء اصطناعي", bookId: 3),
  BookTitleModel(book_title: "تطبيقات ويب", bookId: 4),
  BookTitleModel(book_title: "حوسبة سحابية", bookId: 3),
  BookTitleModel(book_title: "برمجة كائنية", bookId: 4),
  BookTitleModel(book_title: "ادارة مشاريع", bookId: 3),
  // BookTitleModel(book_title: "web", bookId: 4),
];

List<BookDetaile> books = const [
  BookDetaile(
      id: 2,
      category_id: 1,
      patch_id: 2,
      subject: "شبكات",
      img_book: "assets/images/7.jpg",
      name_book: "Clean advanced",
      write_book: "Yousef Hajeb",
      pdfUrl:
          'https://m.media-amazon.com/images/I/41pTqRlersL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg'),
  BookDetaile(
      id: 2,
      category_id: 3,
      patch_id: 2,
      subject: "نطبيقات ذكاء اصطناعي",
      img_book: "assets/images/5.jpg",
      name_book: "PHP form beginer to advanced",
      write_book: "Yousef Hajeb",
      pdfUrl:
          'https://m.media-amazon.com/images/I/41HvCijjVbL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg'),
  BookDetaile(
    id: 2,
    category_id: 3,
    patch_id: 2,
    subject: "تطبيقات ويب",
    img_book: "assets/images/4.jpg",
    name_book: "ابي الجميل",
    write_book: "Yousef Hajeb",
    pdfUrl:
        'https://m.media-amazon.com/images/I/41zWWzbiHpL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg',
  ),
  BookDetaile(
    id: 2,
    category_id: 1,
    patch_id: 2,
    subject: "حوسبة سحابية",
    img_book: "assets/images/2.jpg",
    name_book: "Network form begnersn to advanced",
    write_book: "Yousef Hajeb",
    pdfUrl:
        'https://m.media-amazon.com/images/I/51yfA5Mo1hL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg',
  ),
  BookDetaile(
    id: 2,
    category_id: 2,
    patch_id: 2,
    subject: "برمجة كائنية",
    img_book: "assets/images/11.jpg",
    name_book: "Network form begnersn to advanced",
    write_book: "Yousef Hajeb",
    pdfUrl:
        'https://m.media-amazon.com/images/I/41pTqRlersL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg',
  ),
  BookDetaile(
    id: 2,
    category_id: 2,
    patch_id: 2,
    subject: "OOP",
    img_book: "assets/images/10.jpg",
    name_book: "Network form begnersn to advanced",
    write_book: "Yousef Hajeb",
    pdfUrl:
        'https://m.media-amazon.com/images/I/41pTqRlersL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg',
  ),
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
