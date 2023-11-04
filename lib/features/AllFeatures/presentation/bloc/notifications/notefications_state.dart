part of 'notefications_bloc.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

final class NoteficationsInitial extends NotificationsState {}

final class LoadedNotifications extends NotificationsState {
  final List<Notifications> notifications;

  LoadedNotifications({required this.notifications});
}

final class LoadingNotifications extends NotificationsState {}

final class ErrorNotifications extends NotificationsState {
  final String errorMessage;

  const ErrorNotifications({required this.errorMessage});
}
