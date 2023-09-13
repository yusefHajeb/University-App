part of 'on_boarding_bloc_bloc.dart';

class OnBoardingBlocState extends Equatable {
  int page;

  OnBoardingBlocState({this.page = -1});
  @override
  List<Object> get props => [page++];
}

class OnBoardingBlocInitial extends OnBoardingBlocState {}

// class OnBardingState extends OnBoardingBlocBloc {
  
//   OnBardingState({this.page = 0});
// }
