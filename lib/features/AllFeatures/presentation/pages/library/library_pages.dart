import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/error/execptions.dart';
import 'package:university/core/error/failure.dart';
import 'package:university/features/AllFeatures/presentation/pages/library/downoad_widget.dart';
import 'package:university/features/AllFeatures/presentation/widget/library_widget.dart/convert_book_3d.dart';
import '../../../../../core/Utils/box_decoration.dart';
import '../../../../../core/color/app_color.dart';
import '../../../../../core/fonts/app_fonts.dart';
import '../../../../../core/value/app_space.dart';
import '../../../../../core/widget/animate_in_effect.dart';
import '../../../../../core/widget/dummy/profile_dummy.dart';
import '../../../../../core/widget/fade_effect.dart';
import '../../../data/models/library_models/library_model.dart';
import '../../../domain/entites/header_books_entites.dart';
import '../../bloc/library_bloc/library_bloc.dart';
import '../../widget/library_widget.dart/custom_search.dart';
import '../../widget/library_widget.dart/showdialoge_widget.dart';
// import 'widget_download.dart';

final CarouselController carouselController = CarouselController();

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
    final Dio dio = Dio();
    String newPath = '';
    Future<Either<Failure, BookDetaile>> downloadPDF(
        String url, String filename, BookDetaile book) async {
      Directory? libraryDirectory;
      try {
        Map<Permission, PermissionStatus> statuses =
            await [Permission.storage].request();
        if (statuses[Permission.storage]!.isGranted) {
          libraryDirectory = (await getDownloadsDirectory())!;
          newPath = '';
          List<String> folders = libraryDirectory.path.split('/');
          for (int x = 1; x < folders.length; x++) {
            String folder = folders[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/University";
          libraryDirectory = Directory(newPath);
          print(libraryDirectory.path);

          if (await libraryDirectory.exists()) {
            print("Start downloading PDF"); // رسالة قبل بدء التنزيل
            int progress = 0;
            File saveFile = File('${libraryDirectory.path}/$filename');
            newPath = saveFile.path;
            await dio.download(url, saveFile.path,
                onReceiveProgress: (received, total) {
              print("received: $received, total: $total");
              progress = (received / total).toInt();
              print('progress');
              print(progress);
              // if (total != -1) {
              //   double progress = received / total * 100;
              //   print("Download progress: $progress%");
              // }
            });

            // OpenFilex.open(saveFile.path);
          }
        }
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('تم التنزيل'),
              content: const Text('هل ترغب في فتح الملف؟'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    BlocProvider.of<LibraryBloc>(context).add(
                      DownloadBookLibraryEvent(
                          response: BookDetaile(
                              category_id: book.category_id,
                              img_book: book.img_book,
                              name_book: filename,
                              patch_id: book.patch_id,
                              pdfUrl: newPath)),
                    );
                    print("newPath");
                    print("$newPath/$filename");
                    // OpenFilex.open("$newPath/$filename"); // فتح الملف
                  },
                  child: const Text('نعم'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('لا'),
                ),
              ],
            );
          },
        );

        print("Successfully  ==========");
        return Right(BookDetaile(
            category_id: book.category_id,
            img_book: book.img_book,
            name_book: book.name_book,
            patch_id: book.patch_id,
            pdfUrl: newPath));
      } on ServerException {
        print("حدث خطأ أثناء التنزيل: ");

        return Left(ServerFailure());
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: appSize(context).height,
        color: AppColors.backgroundPages,
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (_) => ReadingBook(
                      //           pdfPath: libraryDirectory.path + "/sample.pdf"),
                      //     ));
                    },
                    child: ProfileDummy(
                        color: HexColor.fromHex("94F0F1"),
                        dummyType: ProfileDummyType.image,
                        scale: 1.1,
                        image: "assets/images/slider-background-3.png"),
                  ),
                ),
                // Image.asset("assets/icons/menus.png", height: 35),
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
              carouselController: carouselController,
              // useing this code when show img from internet

              options: CarouselOptions(
                  height: 120,
                  onPageChanged: (int val, _) {},
                  animateToClosest: false,
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true, //to image show is biger than behaind
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayInterval: const Duration(seconds: 4),
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
                  size: const Size.square(8.0),
                  activeSize: const Size(18.0, 8.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  activeColor: AppColors.primaryAccentColor),
            ),
          ),
          AppSpaces.verticalSpace10,
          BlocConsumer<LibraryBloc, LibraryState>(
            listener: (context, state) {},
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
                              padding: const EdgeInsets.only(right: 5.0),
                              child: ListView.builder(
                                itemCount: state.header.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: ((context, index) {
                                  return InkWell(
                                    onTap: () {
                                      print(
                                          "${state.header[index].book_id} ===== $index");
                                      BlocProvider.of<LibraryBloc>(context).add(
                                          GetHeaderBooksLibraryEvent(index));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      height: 40,
                                      margin: EdgeInsets.only(right: 10),
                                      child: Center(
                                        child: Text(
                                            state.header[index].book_title ??
                                                "",
                                            style: GoogleFonts.almarai(
                                              color: state.index == index
                                                  ? AppColors.white
                                                  : AppColors.white,
                                              fontSize: 12,
                                              fontWeight: state.index == index
                                                  ? FontWeightManager.black
                                                  : FontWeightManager.medium,
                                              // fontWeight: FontWeight.bold
                                            )),
                                      ),
                                      decoration: state.index == index
                                          ? BoxDecorationStyles.headerTab
                                              .copyWith(
                                                  color: Colors.blue.shade200)
                                          : BoxDecorationStyles.headerTab
                                              .copyWith(
                                                  color: AppColors
                                                      .backgroundAccentColor),
                                    ),
                                  );
                                }),
                                // itemCount: state.header.length,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      // space between Header books and content book
                      AppSpaces.verticalSpace10,

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
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 0.8,
                                    mainAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return AnimateInEffect(
                                keepAlive: true,
                                child: InkWell(
                                    onTap: () async {
                                      funcShow(context, state.books[index]);
                                      // Either<Failure, BookDetaile> x= await downloadPDF(
                                      //     pdfUrl, pdfFilename, books[index]);
                                      // x.fold(( failure) =>  , (loaded) => null)
                                      //       Navigator.push(
                                      //           context,
                                      //           MaterialPageRoute(
                                      //             builder: (_) => ReadingBook(
                                      //                 pdfPath:
                                      //                     libraryDirectory.path +
                                      //                         "/sample.pdf"),
                                      //           ));
                                      //     });
                                    },
                                    child: FadeInEffect(
                                      child: BookCover3D(
                                        book: state.books[index],
                                        confige: true,
                                      ),
                                    )),
                              );
                            }),
                      ),
                    ],
                  ),
                );
              } else if (state is ErrorLibraryState) {
                return Center(
                  child: Image.asset("assets/images/on_3.png"),
                );
              } else {
                return Column(
                  children: [
                    const Text("some  woring"),
                    ElevatedButton(
                      child: const Text("try Again"),
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
          TestDownload(
              bookDownload: LibraryModel(
                  pdfUrl: "https://www.fluttercampus.com/sample.pdf"))
        ]),
      ),
    );
  }
}
