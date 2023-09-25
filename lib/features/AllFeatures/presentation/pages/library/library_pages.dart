import 'package:carousel_slider/carousel_slider.dart';
import 'package:dartz/dartz.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:university/core/error/failure.dart';
import 'package:university/core/value/global.dart';
import 'package:university/features/AllFeatures/presentation/widget/library_widget.dart/convert_book_3d.dart';
import 'package:university/features/AllFeatures/presentation/widget/library_widget.dart/keep_reading_section.dart';
import 'package:university/features/AllFeatures/presentation/widget/library_widget.dart/last_opend_book.dart';
import 'package:university/features/AllFeatures/presentation/widget/library_widget.dart/reading_book.dart';
import '../../../../../core/Utils/box_decoration.dart';
import '../../../../../core/color/app_color.dart';
import '../../../../../core/fonts/app_fonts.dart';
import '../../../../../core/value/app_space.dart';
import '../../../../../core/widget/animate_in_effect.dart';
import '../../../domain/entites/header_books_entites.dart';
import '../../bloc/library_bloc/library_bloc.dart';
import '../../widget/library_widget.dart/custom_search.dart';

class Library_page extends StatelessWidget {
  const Library_page({
    Key? key,
    required this.libraryCarouslImg,
    required this.sizeWidth,
    required this.sizeHeight,
  }) : super(key: key);

  final List libraryCarouslImg;
  final double sizeWidth;
  final double sizeHeight;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(children: [
        Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset("assets/icons/menus.png", height: 35),
              CustomInputSerch(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications_none_rounded)),
            ],
          ),
        ),
        AppSpaces.verticalSpace10,
        Container(
          child: CarouselSlider.builder(
            // useing this code when show img from internet
            // items: libraryCarouslImg.map((imageUrl) {
            //   return Container(
            //     width: double.infinity,
            //     decoration: BoxDecorationStyles.fadingInnerDecor,
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.all(Radius.circular(20)),
            //       child: InteractiveViewer(
            //         clipBehavior: Clip.hardEdge,
            //         child: Image.asset(
            //           imageUrl,
            //           fit: BoxFit.cover,
            //         ),
            //       ),
            //     ),
            //   );
            // }).toList(),
            options: CarouselOptions(
                height: 120,
                onPageChanged: (int val, _) {},
                animateToClosest: false,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                initialPage: 0,
                enableInfiniteScroll: true,
                enlargeCenterPage: true, //to image show is biger than behaind
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayInterval: Duration(seconds: 4),
                autoPlay: false),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Container(
                width: double.infinity,
                decoration: BoxDecorationStyles.fadingInnerDecor,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: InteractiveViewer(
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      libraryCarouslImg[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
            itemCount: libraryCarouslImg.length,
          ),
        ),
        Container(
          child: DotsIndicator(
            dotsCount: 4,
            position: 3,
            decorator: DotsDecorator(
                color: AppColors.darkGrey,
                size: Size.square(8.0),
                activeSize: Size(18.0, 8.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                activeColor: AppColors.primaryAccentColor),
          ),
        ),
        AppSpaces.verticalSpace20,

        BlocConsumer<LibraryBloc, LibraryState>(
          listener: (context, state) {
            // if (state is ServiceCurentState) {
            //   BlocProvider.of<ServicesBloc>(context)
            //       .add(ServiceCurentEvent(cureent: state.curent));
            // }
            // state.curent = state.curent;
          },
          builder: (context, state) {
            // int curent = state.curent;
            if (state is LoadingLibraryState) {
              return Container(
                width: sizeWidth,
                color: Color.fromARGB(148, 91, 82, 82),
              );
            } else if (state is HeaderBooksLibraryState) {
              return SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      width: sizeWidth,
                      height: sizeHeight * 40,
                      child: Stack(children: [
                        Positioned(
                          bottom: 3,
                          left: 2,
                          child: Container(
                            width: sizeWidth,
                            height: sizeHeight * 30,
                            // color: Colors.amber,
                            child: ListView.builder(
                              itemCount: state.header.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: ((context, index) {
                                return InkWell(
                                  onTap: () {
                                    print(
                                        "${state.header[index].book_id} ===== $index");
                                    BlocProvider.of<LibraryBloc>(context)
                                        .add(GetHeaderBooksLibraryEvent(index));
                                  },

                                  // }))))
                                  child: Container(
                                    // width: sizeWidth / 4,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    height: 40,
                                    margin: EdgeInsets.only(right: 10),
                                    // width: sizeWidth / state.header.length,
                                    child: Center(
                                      child: Text(
                                          state.header[index].book_title ?? "",
                                          style: GoogleFonts.almarai(
                                            color: state.index == index
                                                ? AppColors.darkRadialBackground
                                                : AppColors
                                                    .darkRadialBackground,
                                            fontSize: 12,
                                            fontWeight: state.index == index
                                                ? FontWeightManager.black
                                                : FontWeightManager.medium,
                                            // fontWeight: FontWeight.bold
                                          )

                                          // TextStyle(

                                          //     color: state.index == index
                                          //         ? AppColors.white
                                          //         : AppColors.darkGrey,
                                          //     fontWeight: state.index == index
                                          //         ? FontWeightManager.black
                                          //         : FontWeightManager.medium,
                                          //     fontSize: 12),
                                          ),
                                    ),
                                    decoration: state.index == index
                                        ? BoxDecorationStyles.headerTab
                                            .copyWith(
                                                color: Colors.blue.shade200)
                                        : BoxDecorationStyles.headerTab
                                            .copyWith(color: AppColors.white),
                                  ),
                                );
                              }),
                              // itemCount: state.header.length,
                            ),
                          ),
                        ),
                        // AnimatedPositioned(
                        //     bottom: 0,
                        //     left: changePostionedLine(
                        //         state.index, context, state.header.length),
                        //     curve: Curves.easeIn,
                        //     duration: Duration(milliseconds: 300),
                        //     child: AnimatedContainer(
                        //       width: 50,
                        //       height: 4,
                        //       decoration: BoxDecorationStyles.backgroundBlack,
                        //       duration: Duration(milliseconds: 400),
                        //     ))
                      ]),
                    ),
                    // space between Header books and content book
                    AppSpaces.verticalSpace20,

                    // LastOpenedBook(),
                    KeepReadingSection(
                      books: state.books,
                    ),
                    // AllPurchasedBooks(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          itemCount: state.index != 0
                              ? state.books
                                  .where(
                                    (element) =>
                                        element.category_id == state.index,
                                  )
                                  .toList()
                                  .length
                              : state.books.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 7,
                                  childAspectRatio: 0.8,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            // List<BookDetaile> checkBook = state.books
                            //     .where((element) => element.category_id == 1)
                            //     .toList();
                            print("Clike ${state.index} =====");

                            // List<BookDetaile> book = state.index != 0
                            //     ? state.books
                            //         .where(
                            //           (element) =>
                            //               element.category_id == state.index,
                            //         )
                            //         .toList()
                            //     : state.books;
                            return AnimateInEffect(
                              keepAlive: true,
                              child: InkWell(
                                  onTap: () {
                                    BlocProvider.of<LibraryBloc>(context)
                                        .add(DownloadBookLibraryEvent(
                                      response:
                                          starDownload(state.books[index]),
                                    ));
                                    // funcShow(context, book[index]);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ReadingBook(
                                                pdfPath:
                                                    "assets/pdf/harry_potter.pdf")));
                                  },
                                  child: BookCover3D(
                                    url: state.books[index].pdfUrl.toString(),
                                    confige: true,
                                  )),
                            );
                          }),
                    )
                  ],
                ),
              );
            } else if (state is ErrorLibraryState) {
              return Center(
                child: Image.asset(""),
              );
            } else {
              return Column(
                children: [
                  Text("some  woring"),
                  ElevatedButton(
                    child: Text("try Again"),
                    onPressed: () {
                      BlocProvider.of<LibraryBloc>(context)
                          .add(GetHeaderBooksLibraryEvent(0));
                    },
                  )
                ],
              );
            }
          },
        ),
        AppSpaces.verticalSpace20,

        // ContentBook(),
      ]),
    );
  }

  Future<Either<Failure, BookDetaile>> starDownload(BookDetaile book) async {
    if (await Global.storgeServece.checkNetWork()) {
      return Right(book);
    } else {
      return Left(OffLineFailure());
    }
  }
}
