part of 'services_bloc.dart';

class ServicesState extends Equatable {
  int curent;
  int leftCurent;
  ServicesState({this.curent = 0, this.leftCurent = 0});

  @override
  List<Object> get props => [curent];
}

class ServicesInitial extends ServicesState {
  ServicesInitial();
}

class ServiceCurentState extends ServicesState {
  int cureent;
  ServiceCurentState({this.cureent = 0});
  @override
  List<Object> get props => [cureent];
}

class ServiceLineUnderTab extends ServicesState {
  int index;
  ServiceLineUnderTab({this.index = 0});
  @override
  List<Object> get props => [index];
}
