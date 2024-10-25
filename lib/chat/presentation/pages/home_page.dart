import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/presentation/cubit/auth/auth_cubit.dart';
import 'package:university/chat/presentation/cubit/group/group_cubit.dart';
import 'package:university/chat/presentation/cubit/user/user_cubit.dart';
import 'package:university/chat/presentation/pages/all_users_page.dart';
import 'package:university/chat/presentation/pages/groups_page.dart';
import 'package:university/chat/presentation/pages/profile_page.dart';
import 'package:university/chat/presentation/widgets/customTabBar.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';
import 'package:university/core/color/app_color.dart';
import 'package:university/core/value/style_manager.dart';

class HomePage extends StatefulWidget {
  final StudentEntity uid;

  const HomePage({Key? key, required this.uid}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchTextController = TextEditingController();
  final PageController _pageController = PageController(initialPage: 0);
  //IO.Socket? socket;
  List<Widget> get pages => [
        GroupsPage(
          uid: widget.uid,
          query: _searchTextController.text,
        ),
        AllUsersPage(
          uid: widget.uid,
          query: _searchTextController.text,
        ),
        ProfilePage(
          uid: widget.uid,
        )
      ];

  int _currentPageIndex = 0;
  bool _isSearch = false;
  @override
  void dispose() {
    _searchTextController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // connectSocket();
    super.initState();
    BlocProvider.of<UserCubit>(context).getUsers(widget.uid.batch_id);
    BlocProvider.of<GroupCubit>(context).getGroups(widget.uid.batch_id);
    _searchTextController.addListener(() {
      setState(() {});
    });
  }

  _buildSearchField() {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      height: 40,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(.3),
            spreadRadius: 1,
            offset: const Offset(0, 0.50))
      ]),
      child: TextField(
        controller: _searchTextController,
        decoration: InputDecoration(
          hintText: "Search...",
          border: InputBorder.none,
          prefixIcon: InkWell(
              onTap: () {
                setState(() {
                  _isSearch = false;
                });
              },
              child: Icon(
                Icons.arrow_back,
                size: 25,
                color: primaryColor,
              )),
          hintStyle: const TextStyle(),
        ),
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: _isSearch == false ? primaryColor : Colors.transparent,
        title: _isSearch == false
            ? Text(
                "منصة جامعتي",
                style: getFontNormal(20, FontWeight.bold, AppColors.white),
              )
            : const SizedBox(
                height: 0.0,
                width: 0.0,
              ),
        flexibleSpace: _isSearch == true
            ? _buildSearchField()
            : const SizedBox(
                height: 0.0,
                width: 0.0,
              ),
        actions: _isSearch == false
            ? [
                InkWell(
                    onTap: () {
                      setState(() {
                        _isSearch = true;
                      });
                    },
                    child: const Icon(Icons.search)),
                const SizedBox(
                  width: 5,
                ),
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        enabled: true,
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              BlocProvider.of<AuthCubit>(context).loggedOut();
                            },
                            child: const Text("logout")),
                      ),
                    ];
                  },
                ),
              ]
            : [],
      ),
      body: Container(
        child: Column(
          children: [
            _isSearch == false
                ? CustomTabBar(
                    index: _currentPageIndex,
                    tabClickListener: (index) {
                      print(index);
                      _currentPageIndex = index;
                      _pageController.jumpToPage(index);
                    },
                  )
                : const SizedBox(
                    width: 0.0,
                    height: 0.0,
                  ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemCount: pages.length,
                itemBuilder: (_, index) {
                  return pages[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
