part of 'services_bloc.dart';

class ServicesEvent extends Equatable {
  const ServicesEvent();

  @override
  List<Object> get props => [];
}

class ServiceCurentEvent extends ServicesEvent {
  int cureent;
  ServiceCurentEvent({this.cureent = 0});
  List<Object> get props => [cureent];
}
