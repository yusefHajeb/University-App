import 'package:flutter/material.dart';

import '../../../../../core/Utils/box_decoration.dart';
import '../../../../../core/value/app_space.dart';
import '../../../../../core/widget/animate_in_effect.dart';

class CardSchedule extends StatelessWidget {
  const CardSchedule({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecorationStyles.fadingGlory,
        child: Padding(
          padding: EdgeInsets.all(1),
          child: DecoratedBox(
            decoration: BoxDecorationStyles.fadingGlory,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                AppSpaces.verticalSpace10,
                AnimateInEffect(
                  child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecorationStyles.fadingInnerDecor),
                ),
                AppSpaces.verticalSpace10,
                AnimateInEffect(
                  child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecorationStyles.fadingInnerDecor),
                ),
                AppSpaces.verticalSpace10,
                AnimateInEffect(
                  child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecorationStyles.fadingInnerDecor),
                ),
                AppSpaces.verticalSpace10,
                Container(
                    width: double.infinity,
                    height: 200,
                    child: Padding(
                      padding: EdgeInsets.all(3.0),
                      child: DecoratedBox(
                        decoration: BoxDecorationStyles.fadingInnerDecor,
                        child: Padding(padding: EdgeInsets.all(20)),
                      ),
                    ),
                    decoration: BoxDecorationStyles.fadingInnerDecor),
                AppSpaces.verticalSpace10,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
