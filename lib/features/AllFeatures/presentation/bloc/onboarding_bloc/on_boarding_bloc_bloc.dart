import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_bloc_event.dart';
part 'on_boarding_bloc_state.dart';

class OnBoardingBlocBloc
    extends Bloc<OnBoardingBlocEvent, OnBoardingBlocState> {
  OnBoardingBlocBloc() : super(OnBoardingBlocState()) {
    on<OnBoardingBlocEvent>((event, emit) {
      emit(OnBoardingBlocState(page: state.page));
    });
  }
}
