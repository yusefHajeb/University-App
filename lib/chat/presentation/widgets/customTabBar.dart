import 'package:flutter/material.dart';
import 'package:university/app_localizations.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';
import 'package:university/core/value/style_manager.dart';

typedef TabClickListener = Function(int index);

class CustomTabBar extends StatefulWidget {
  final TabClickListener tabClickListener;
  final index;

  const CustomTabBar({Key? key, this.index = 0, required this.tabClickListener})
      : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int _indexHolder = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TabBarCustomButton(
              width: 50,
              text: "الدردشة الجماعية",
              textColor: widget.index == 0 ? textIconColor : textIconColorGray,
              borderColor: widget.index == 0 ? textIconColor : primaryColor,
              onTap: () {
                setState(() {
                  _indexHolder = 0;
                });
                widget.tabClickListener(_indexHolder);
              },
            ),
          ),
          Expanded(
            child: TabBarCustomButton(
              text: "المحادثات",
              textColor: widget.index == 1 ? textIconColor : textIconColorGray,
              borderColor:
                  widget.index == 1 ? textIconColor : Colors.transparent,
              onTap: () {
                setState(() {
                  _indexHolder = 1;
                });
                widget.tabClickListener(_indexHolder);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TabBarCustomButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color borderColor;
  final double borderWidth;
  final Color textColor;
  final VoidCallback onTap;

  const TabBarCustomButton({
    Key? key,
    this.text = "",
    this.width = 50.0,
    this.height = 60.0,
    this.borderColor = Colors.white,
    this.borderWidth = 3.0,
    this.textColor = Colors.white,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(text,
                textAlign: TextAlign.center,
                style: getFontNormal(14, FontWeight.w400, Colors.white)),
            SizedBox(height: 5),
            Container(
              width: 30,
              height: 7,
              decoration: BoxDecoration(
                  color: borderColor, borderRadius: BorderRadius.circular(30)),
            )
          ],
        ),
      ),
    );
  }
}
