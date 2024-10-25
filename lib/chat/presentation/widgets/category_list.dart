import 'package:flutter/material.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';

class CategoryList extends StatelessWidget {
  CategoryList({super.key});
  ScrollController scrollController = ScrollController();

  final List<String> categories = [
    'الزملاء',
    'الوسائط',
    'المستندات',
    'التسجيلات',
  ];

  void goToBottom(double day) {
    for (int i = 1; i <= 8; i++) {
      Future.delayed(Duration(milliseconds: i * 50), () {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            100 * day,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),

      child: DefaultTabController(
        length: categories.length,
        child: Column(
          children: [
            TabBar(
              isScrollable: true,
              tabs: categories.map((String category) {
                return Tab(
                  text: category,
                );
              }).toList(),
            ),
            Expanded(
              child: TabBarView(
                children: categories.map((String category) {
                  return Center(
                    child: Text(category),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),

      // GetBuilder<Homecontroller>(
      //     init: Homecontroller(),
      //     builder: (controller) {
      //       goToBottom(controller.day.toDouble());
      //       return }),
    );
  }
}
