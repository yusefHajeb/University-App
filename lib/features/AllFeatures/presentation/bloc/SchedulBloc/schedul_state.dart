part of 'schedul_bloc.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class SchedulInitial extends ScheduleState {}

class LoadingSchedulState extends ScheduleState {}

class LoadedSchedulState extends ScheduleState {
  final List<Schedule> schedule;
  int index;
  String day;
  LoadedSchedulState({required this.schedule, this.index = 0, this.day = ''});
  @override
  List<Object> get props => [schedule, index, day];
}

class ErrorSchedulState extends ScheduleState {
  final String message;
  const ErrorSchedulState({required this.message});
  @override
  List<Object> get props => [message];
}

class NotificationScheduleState extends ScheduleState {
  final Schedule schedule;

  NotificationScheduleState({required this.schedule});

  @override
  List<Object> get props => [schedule];
}
