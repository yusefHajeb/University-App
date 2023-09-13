// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:university/core/Utils/lang/app_localization.dart';
// import 'package:university/features/AllFeatures/presentation/widget/onBoarding/slider_image.dart';

// import '../../bloc/Onboarding/onboarding_cubit.dart';
// import '../../pages/Auth/singup_page.dart';

// class CustomSlider extends StatelessWidget {
//   const CustomSlider({
//     Key? key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final myCubit = BlocProvider.of<OnboardingCubit>(context);
//     List<dynamic> listSliderPage = [
//       SliderCaptionedImage(
//           index: 0,
//           imageUrl: "assets/images/slider-background-1.png",
//           caption: "onBoarding1".tr(context)),
//       SliderCaptionedImage(
//           index: 1,
//           imageUrl: "assets/images/slider-background-3.png",
//           caption: "onBoarding2".tr(context)),
//       SliderCaptionedImage(
//           index: 2,
//           imageUrl: "assets/images/slider-background-2.png",
//           caption: "onBoarding3".tr(context))
//     ];
//     final OnboardingCubit boardingCubit =
//         OnboardingCubit(pageController: PageController());

//     return BlocConsumer<OnboardingCubit, int>(
//       listener: ((context, state) {
//         listSliderPage[state];
//       }),
//       // bloc: boardingCubit,
//       builder: ((context, currentIndex) {
//         return PageView(
//             physics: ClampingScrollPhysics(),
//             controller: boardingCubit.pageController,
//             onPageChanged: (state) {
//               print("$state ========");
//               OnboardingDirection dirction;
//               if (state >= 0) {
//                 if (state >= currentIndex) {
//                   dirction = OnboardingDirection.forward;
//                   BlocProvider.of<OnboardingCubit>(context)
//                       .changePage(state + 1, dirction);
//                 } else {
//                   dirction = OnboardingDirection.reverse;
//                   BlocProvider.of<OnboardingCubit>(context)
//                       .changePage(state - 1, dirction);
//                 }
//                 BlocProvider.of<OnboardingCubit>(context)
//                     .changePage(state, dirction);
//               }
//             },
//             children: <Widget>[
//               SliderCaptionedImage(
//                   index: 0,
//                   imageUrl: "assets/images/slider-background-1.png",
//                   caption: "onBoarding1".tr(context)),
//               SliderCaptionedImage(
//                   index: 1,
//                   imageUrl: "assets/images/slider-background-3.png",
//                   caption: "onBoarding2".tr(context)),
//               SliderCaptionedImage(
//                   index: 2,
//                   imageUrl: "assets/images/slider-background-2.png",
//                   caption: "onBoarding3".tr(context))
//             ]);
//       }),
//     );
//   }
// }
