part of 'schedul_bloc.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class SchedulInitial extends ScheduleState {}

class LoadingSchedulState extends ScheduleState {}

// ignore: must_be_immutable
class LoadedSchedulState extends ScheduleState {
  final List<Schedule> schedule;
  int index;
  String day;
  bool check;
  LoadedSchedulState(
      {required this.schedule,
      this.index = 0,
      this.day = '',
      this.check = false});
  @override
  List<Object> get props => [schedule, index, day, check];
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
