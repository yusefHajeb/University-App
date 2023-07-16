part of 'schedul_bloc.dart';

abstract class SchedulEvent extends Equatable {
  const SchedulEvent();

  @override
  List<Object> get props => [];
}

class GetAllScheduleEvent extends SchedulEvent {}

class RefreshScheduleEvent extends SchedulEvent {}

class NotificationScheduleEvent extends SchedulEvent {}
