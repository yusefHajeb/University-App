import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

// part 'onboarding_state.dart';

enum OnboardingState {
  Initial,
  Loading,
  PageChanged,
  Complete,
}

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState.Initial);

  void loadOnboardingData() async {
    emit(OnboardingState.Loading);
  }

  void onChangePage(int index) async {
    if (index < 3) {
      emit(OnboardingState.PageChanged);
    } else {
      complete();
    }
  }

  void complete() async {
    emit(OnboardingState.Complete);
  }
}
