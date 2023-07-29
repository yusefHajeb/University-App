import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/features/AllFeatures/presentation/pages/schedule_page.dart';
import 'package:university/features/AllFeatures/presentation/routes.dart';

// part 'onboarding_state.dart';

enum OnboardingDirection { forward, reverse }

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit({required this.pageController}) : super(0);
  PageController pageController;
  int currentPage = 0;
  // void loadOnboardingData() async {
  //   emit(OnboardingDirection.Loading);
  // }

  void inital() {
    pageController = PageController();
    // emit(OnboardingDirection.Loading);
  }

  void changePage(int index, OnboardingDirection direction) {
    print("==============$state state");
    if (direction == OnboardingDirection.forward) {
      if (state < 3) {
        emit(index + 1);
      }
    } else if (direction == OnboardingDirection.reverse) {
      if (index > 0) emit(index - 1);
    }
  }
}
