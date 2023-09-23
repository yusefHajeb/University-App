part of 'on_boarding_bloc_bloc.dart';

// ignore: must_be_immutable
class OnBoardingBlocState extends Equatable {
  int page;

  OnBoardingBlocState({this.page = -1});
  @override
  List<Object> get props => [page++];
}

// ignore: must_be_immutable
class OnBoardingBlocInitial extends OnBoardingBlocState {}

// class OnBardingState extends OnBoardingBlocBloc {
  
//   OnBardingState({this.page = 0});
// }
