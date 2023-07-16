part of 'schedul_bloc.dart';

abstract class SchedulState extends Equatable {
  const SchedulState();

  @override
  List<Object> get props => [];
}

class SchedulInitial extends SchedulState {}

class LoadingSchedulState extends SchedulState {}

class LoadedSchedulState extends SchedulState {
  final List<Schedule> schedule;
  const LoadedSchedulState({required this.schedule});
  @override
  List<Object> get props => [schedule];
}

class ErrorSchedulState extends SchedulState {
  final String message;
  const ErrorSchedulState({required this.message});
  @override
  List<Object> get props => [message];
}

class NotificationScheduleState extends SchedulState {
  final Schedule schedule;

  NotificationScheduleState({required this.schedule});

  @override
  List<Object> get props => [schedule];
}
