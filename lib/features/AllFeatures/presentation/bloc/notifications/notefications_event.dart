part of 'notefications_bloc.dart';

sealed class NoteficationsEvent extends Equatable {
  const NoteficationsEvent();

  @override
  List<Object> get props => [];
}

final class GetNotifications extends NoteficationsEvent {}
