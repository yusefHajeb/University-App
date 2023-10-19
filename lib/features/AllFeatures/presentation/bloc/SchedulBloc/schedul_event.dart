part of 'schedul_bloc.dart';

abstract class SchedulEvent extends Equatable {
  const SchedulEvent();

  @override
  List<Object> get props => [];
}

class GetAllScheduleEvent extends SchedulEvent {
  final int index;

  const GetAllScheduleEvent({required this.index});
  @override
  List<Object> get props => [index];
}

class SelectDayScheduleEvent extends SchedulEvent {
  final int index;
  final String day;
  const SelectDayScheduleEvent({required this.day, required this.index});
  @override
  List<Object> get props => [index, day];
}

class RefreshScheduleEvent extends SchedulEvent {}

class NotificationScheduleEvent extends SchedulEvent {}
