part of 'on_boarding_bloc_bloc.dart';

class OnBoardingBlocEvent extends Equatable {
  const OnBoardingBlocEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class SetValueChange extends OnBoardingBlocEvent {
  int value;
  SetValueChange({required this.value});
}
