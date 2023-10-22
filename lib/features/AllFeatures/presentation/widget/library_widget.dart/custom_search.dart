import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:university/features/AllFeatures/presentation/bloc/search_books/search_books_bloc.dart';

import '../../../../../core/color/app_color.dart';

class CustomInputSerch extends StatelessWidget {
  const CustomInputSerch({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeWidth = ScreenUtil().screenWidth;

    return Expanded(
      child: Container(
          height: sizeWidth / 10,
          width: sizeWidth / 1.27,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: sizeWidth / 30, bottom: 8),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: AppColors.backgrounfContent,
            ),
            color: Colors.black.withOpacity(.05),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            // controller: controller,
            validator: (val) => val!.isEmpty ? "Can/'t be empty" : null,
            style: TextStyle(
                fontSize: 14,
                color: AppColors.greyColor,
                fontWeight: FontWeight.w600),
            onChanged: (value) {
              context
                  .read<SearchBooksBloc>()
                  .add(SetVlaueSearched(value: value));
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                textDirection: TextDirection.rtl,
                Icons.search,
                color: AppColors.backgrounfContent,
              ),
              counterStyle: TextStyle(fontSize: 14, color: AppColors.greyColor),
              border: InputBorder.none,
              hintMaxLines: 1,
              hintText: "",
              hintStyle: TextStyle(fontSize: 14, color: AppColors.greyColor),
            ),
          )),
    );
  }
}
