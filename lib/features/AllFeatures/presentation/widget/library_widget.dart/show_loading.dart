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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: Column(
              children: [
                Skelton(
                  height: 20,
                  width: 230,
                ),
                SizedBox(
                  height: 5,
                ),
                Skelton(
                  height: 20,
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
        const SizedBox(
          height: 40,
        ),
        Column(
          children: [
            Skelton(
              width: size.width - 50,
              height: size.height / 3,
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Skelton(
                      height: 20,
                      width: 230,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Skelton(
                      height: 20,
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
            const SizedBox(
              height: 30,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Skelton(
                      height: 20,
                      width: 230,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Skelton(
                      height: 20,
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
            const SizedBox(
              height: 30,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Skelton(
                      height: 20,
                      width: 230,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Skelton(
                      height: 20,
                      width: 230,
                    ),
                  ],
                )),
                Skelton(
                  height: 25,
                  width: 120,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
