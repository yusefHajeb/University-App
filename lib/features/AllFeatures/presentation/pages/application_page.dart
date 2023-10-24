import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/color/app_color.dart';
import 'package:university/core/widget/application_wedget.dart';
import 'package:university/features/AllFeatures/data/models/user_data.dart';
import 'package:university/features/AllFeatures/presentation/bloc/lading_page/lading_page_bloc.dart';
import 'package:university/features/AllFeatures/presentation/resources/assets_mananger.dart';

import '../../data/models/auth_models/singup_model.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class ApplicationPage extends StatelessWidget {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    List libraryCarouslImg = const [
      ImageAssets.imageOne,
      ImageAssets.imageTow,
      ImageAssets.imageThree
    ];
    // final sizeWidth = ScreenUtil().screenWidth;
    // final sizeHeight = ScreenUtil().scaleHeight;

    return BlocConsumer<LadingPageBloc, LadingPageState>(
      // this to bottomnavigation Bar to button
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
          drawer: DrawerWidget(context),
          bottomNavigationBar: Container(
            height: 60,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyColor.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(20))),
            child: BottomNavigationBar(
              items: bottomNavItems,
              // fixedColor: AppColors.greyColor,
              // elevation: 0,
              // backgroundColor: AppColors.error,

              currentIndex: state.tabIndex,
              showSelectedLabels: true,

              selectedItemColor: AppColors.greyColor,

              onTap: ((value) {
                //get data to index in bloc and refresh value in ui
                BlocProvider.of<LadingPageBloc>(context).add(TabChange(value));
              }),
            ),
          ),
          // body: buildPage(state.tabIndex),

          // when state.tabindex =1 not use singleChil... .becuase show error
          body: buildPage(state.tabIndex, context),
          // ? buildPage(state.tabIndex, context)
          // : SingleChildScrollView(
          //     child: buildPage(state.tabIndex, context)),
        ));
      },
    );
  }
}

Widget DrawerWidget(BuildContext context) {
  SingUpModel student = userDataModel();
  return AnimatedContainer(
    duration: Duration(),
    transform: Matrix4.translationValues(
      -200,
      0,
      0,
    ),
    child: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(student.image.toString()),
                ),
                SizedBox(height: 10),
                const Text(
                  'John Doe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 300,
            child: Expanded(
                child: ListView(shrinkWrap: true, children: <Widget>[
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.settings),
              //   title: Text('Settings'),
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              // ),
            ])),
          ),
        ],
      ),
    ),
  );
}
