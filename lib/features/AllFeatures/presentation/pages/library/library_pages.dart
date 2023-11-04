import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/widget/dummy/image_net.dart';
import 'package:university/features/AllFeatures/presentation/bloc/lading_page/lading_page_bloc.dart';
import 'package:university/features/AllFeatures/presentation/bloc/onboarding_bloc/on_boarding_bloc_bloc.dart';
import 'package:university/features/AllFeatures/presentation/bloc/search_books/search_books_bloc.dart';
import 'package:university/features/AllFeatures/presentation/widget/library_widget.dart/convert_book_3d.dart';
import '../../../../../core/Utils/box_decoration.dart';
import '../../../../../core/color/app_color.dart';
import '../../../../../core/fonts/app_fonts.dart';
import '../../../../../core/value/app_space.dart';
import '../../../../../core/widget/animate_in_effect.dart';
import '../../../../../core/widget/custom_drawer.dart';
import '../../../../../core/widget/fade_effect.dart';
import '../../bloc/library_bloc/library_bloc.dart';
import '../../widget/library_widget.dart/custom_search.dart';
import '../../widget/library_widget.dart/show_loading.dart';

class LibraryPage extends StatefulWidget {
  LibraryPage({
    Key? key,
    required this.libraryCarouslImg,
    required this.sizeWidth,
    required this.sizeHeight,
  }) : super(key: key);

  final List libraryCarouslImg;
  final double sizeWidth;
  final double sizeHeight;

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late CarouselController carouselController;
  int curent = 0;

  @override
  initState() {
    carouselController = CarouselController();
    curent = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: true,
      drawer: DrawerWidget(),
      backgroundColor: AppColors.backgroundPages,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: appSize(context).height,
          color: AppColors.backgroundPages,
          child: ListView(shrinkWrap: true, children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: new Icon(
                        Icons.menu,
                        color: AppColors.greyColor,
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                  CustomInputSerch(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        context.read<LadingPageBloc>().add(TabChange(4));
                      },
                      child: ProfileDummyNet(
                        color: HexColor.fromHex("94F0F1"),
                        dummyType: ProfileDummyTypeNet.icon,
                        scale: 1,

                        // image: userDataModel().image,
                        icon: Icons.person,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppSpaces.verticalSpace10,
            Stack(
              children: [
                CarouselSlider.builder(
                  carouselController: carouselController,
                  itemCount: widget.libraryCarouslImg.length,
                  itemBuilder: (context, index, realIndex) {
                    context
                        .read<OnBoardingBlocBloc>()
                        .add(SetValueChange(value: index));

                    return SizedBox(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: InteractiveViewer(
                          clipBehavior: Clip.hardEdge,
                          child: Image.asset(
                            widget.libraryCarouslImg[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                      animateToClosest: false,
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      initialPage: 0,
                      height: 120,
                      enableInfiniteScroll: true,
                      enlargeCenterPage:
                          true, //to image show is biger than behaind
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayInterval: const Duration(seconds: 4),
                      autoPlay: true),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 10,
                  child: BlocConsumer<OnBoardingBlocBloc, OnBoardingBlocState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return DotsIndicator(
                        dotsCount: widget.libraryCarouslImg.length,
                        position: state.page,
                        onTap: (val) {},
                        decorator: DotsDecorator(
                            color: AppColors.darkGrey,
                            size: const Size.square(8.0),
                            activeSize: const Size(18.0, 8.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            activeColor: AppColors.primaryAccentColor),
                      );
                    },
                  ),
                ),
              ],
            ),
            AppSpaces.verticalSpace10,
            BlocConsumer<LibraryBloc, LibraryState>(
              listener: (context, state) {},
              builder: (context, state) {
                // int curent = state.curent;
                if (state is LoadingLibraryState) {
                  return ShowSktolin(
                    size: appSize(context),
                  );
                } else if (state is HeaderBooksLibraryState) {
                  return BlocBuilder<SearchBooksBloc, SearchBooksState>(
                      builder: (context, stateSearch) {
                    return SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              width: widget.sizeWidth,
                              height: widget.sizeHeight * 40,
                              child: Stack(children: [
                                Positioned(
                                  bottom: 3,
                                  left: 2,
                                  child: Container(
                                    width: widget.sizeWidth,
                                    height: widget.sizeHeight * 30,
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: ListView.builder(
                                      itemCount: state.header.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: ((context, index) {
                                        return InkWell(
                                          onTap: () {
                                            print(
                                                "${state.header[index].book_id} :header books || index is : $index");

                                            print(state.books
                                                .where((element) =>
                                                    element.courseId ==
                                                    state.header[index].book_id)
                                                .toList());
                                            BlocProvider.of<LibraryBloc>(
                                                    context)
                                                .add(
                                              GetHeaderBooksLibraryEvent(index),
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            height: 40,
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: Center(
                                              child: Text(
                                                  state.header[index]
                                                          .book_title ??
                                                      "",
                                                  style: GoogleFonts.almarai(
                                                    color: state.index == index
                                                        ? AppColors.white
                                                        : AppColors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        state.index == index
                                                            ? FontWeightManager
                                                                .black
                                                            : FontWeightManager
                                                                .medium,
                                                    // fontWeight: FontWeight.bold
                                                  )),
                                            ),
                                            decoration: state.index == index
                                                ? BoxDecorationStyles.headerTab
                                                    .copyWith(
                                                        color: AppColors
                                                            .backgrounfContent)
                                                : BoxDecorationStyles.headerTab
                                                    .copyWith(
                                                        color: AppColors
                                                            .backgroundPages),
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
                                  shrinkWrap: true,
                                  itemCount: stateSearch.books.isEmpty
                                      ? state.books
                                          .where((element) =>
                                              element.courseId ==
                                              state.header[state.index].book_id)
                                          .toList()
                                          .length
                                      : stateSearch.books.length,
                                  //             .length
                                  //  stateSearch.books.isEmpty
                                  //     ? state.index != 0
                                  //         ? state.books
                                  //             .where(
                                  //               (element) =>
                                  //                   element.course_id ==
                                  //                   state.index,
                                  //             )
                                  //             .toList()
                                  //             .length
                                  //         : state.books.length
                                  //     : stateSearch.books.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 10,
                                          childAspectRatio: 0.8,
                                          mainAxisSpacing: 10),
                                  itemBuilder: (context, i) {
                                    return AnimateInEffect(
                                      keepAlive: true,
                                      child: InkWell(
                                          onTap: () async {},
                                          child: FadeInEffect(
                                            child: BookCover3D(
                                              book: stateSearch.books.isEmpty
                                                  ? state.books
                                                      .where((element) =>
                                                          element.courseId ==
                                                          state
                                                              .header[
                                                                  state.index]
                                                              .book_id)
                                                      .toList()[i]
                                                  : stateSearch.books[i],
                                              confige: true,
                                            ),
                                          )),
                                    );
                                  }),
                            ),
                          ],
                        ));
                  });
                } else if (state is ErrorLibraryState) {
                  return Center(
                    child: Image.asset("assets/images/on_3.png"),
                  );
                } else {
                  return ShowSktolin(
                    size: appSize(context),
                  );
                }
              },
            ),
            AppSpaces.verticalSpace20,
          ]),
        ),
      ),
    );
  }
}
