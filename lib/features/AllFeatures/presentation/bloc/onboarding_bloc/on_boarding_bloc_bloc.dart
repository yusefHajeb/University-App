import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_bloc_event.dart';
part 'on_boarding_bloc_state.dart';

class OnBoardingBlocBloc
    extends Bloc<OnBoardingBlocEvent, OnBoardingBlocState> {
  OnBoardingBlocBloc() : super(OnBoardingBlocState(page: 0)) {
    on<SetValueChange>((event, emit) {
      print(" ======  state in bloc");
      // final page = state.page + event.value;
      emit(OnBoardingBlocState(page: event.value));
    });
  }
}
