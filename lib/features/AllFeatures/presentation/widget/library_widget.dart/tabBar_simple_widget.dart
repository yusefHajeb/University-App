import 'package:flutter/material.dart';

import '../../../../../core/color/app_color.dart';

class TabBarHeader extends StatefulWidget {
  const TabBarHeader({super.key, required this.index, required this.title});
  final int index;
  final String title;
  @override
  State<TabBarHeader> createState() => _TabBarHeaderState();
}

class _TabBarHeaderState extends State<TabBarHeader>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // super.initState();
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("clikkked");

        tabController.animateTo(widget.index);
      },
      child: Container(
        width: double.infinity,
        height: 80,
        padding: EdgeInsets.symmetric(vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            // shrinkWrap: true,
            // scrollDirection: Axis.vertical,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    // color: AppColors.primaryColor,
                    color: widget.index == tabController.index
                        ? AppColors.primaryAccentColor
                        : AppColors.darkGrey,
                    fontSize: 12,
                    fontWeight: widget.index == tabController.index
                        ? FontWeight.bold
                        : FontWeight.normal),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                margin: EdgeInsets.only(top: 8),
                height: 3,
                width: 30,
                curve: Curves.fastLinearToSlowEaseIn,
                color: tabController.index == widget.index
                    ? AppColors.primaryDarkColor
                    : Colors.transparent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
