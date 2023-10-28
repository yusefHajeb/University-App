import 'package:flutter/material.dart';
import 'package:university/features/AllFeatures/presentation/widget/library_widget.dart/skelton.dart';

class ShowSktolin extends StatelessWidget {
  const ShowSktolin({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  child: Column(
                children: [
                  Skelton(
                    height: 24,
                    width: 230,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Skelton(
                    height: 24,
                    width: 230,
                  ),
                ],
              )),
              Skelton(
                height: 30,
                width: 120,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: GridView.builder(
            itemBuilder: (context, index) => Skelton(
              height: 30,
              width: 120,
            ),
            itemCount: 6,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
                mainAxisSpacing: 10),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
