// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:university/core/fonts/app_fonts.dart';
import 'package:university/core/value/style_manager.dart';

import '../color/app_color.dart';
import '../value/app_space.dart';
// import 'package:google_fonts/google_fonts.dart';

class LabelledFormInput extends StatelessWidget {
  final String? label;
  final String? placeholder;
  final bool? isNumber;
  final String hint;
  final TextEditingController controller;
  const LabelledFormInput({
    Key? key,
    required this.hint,
    required this.controller,
    required this.placeholder,
    required this.label,
    this.isNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myTheme =
        getFontNormal(18, FontWeightManager.bold, AppColors.greyColor);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.verticalSpace10,
        Text(
          label!.toUpperCase(),
          textAlign: TextAlign.left,
          style: myTheme.copyWith(color: HexColor.fromHex("3C3E49")),
          // style: Theme.of(context).textTheme.bodyMedium.backgroundColor(color: HexColor.fromHex("3C3E49")),
        ),
        TextFormField(
          controller: controller,
          style: myTheme,
          textAlign: TextAlign.right,
          // .copyWith(fontSize: 18, color: AppColors.greyColor),
          onTap: () {},

          keyboardType:
              (isNumber ?? false) ? TextInputType.number : TextInputType.text,
          validator: (val) => val!.isEmpty ? "$label Can/'t be empty" : null,
          //initialValue: initialValue,

          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 10,
              ),
              suffixIcon: _suffixWidget(controller),
              filled: false,
              hintText: hint,
              hintStyle: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: HexColor.fromHex("3C3E49")),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: HexColor.fromHex("3C3E49")),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: HexColor.fromHex("BEF0B2")),
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: HexColor.fromHex("BEF0B2")))),
        ),
      ],
    );
  }

  Widget _suffixWidget(TextEditingController controller) {
    return InkWell(
      onTap: () {
        controller.text = "";
      },
      child: const Icon(FontAwesomeIcons.solidTimesCircle,
          color: Colors.white24, size: 20),
    );
  }
}
