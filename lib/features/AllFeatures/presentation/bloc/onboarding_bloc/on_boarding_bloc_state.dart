part of 'on_boarding_bloc_bloc.dart';

// ignore: must_be_immutable
class OnBoardingBlocState extends Equatable {
  int page;

  OnBoardingBlocState({required this.page});
  @override
  List<Object> get props => [page];
}

// ignore: must_be_immutable

// class OnBardingState extends OnBoardingBlocBloc {
  
//   OnBardingState({this.page = 0});
// }
