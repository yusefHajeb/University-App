import 'package:flutter/cupertino.dart';

import '../color/app_color.dart';

Size sizeHeight(BuildContext context) {
  return MediaQuery.of(context).size;
}

const kCalendarDay = TextStyle(
  color: AppColors.kTextColor,
  fontSize: 16.0,
);
