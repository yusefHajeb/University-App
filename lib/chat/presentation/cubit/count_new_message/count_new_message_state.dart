part of 'count_new_message_cubit.dart';

abstract class CountNewMessageState extends Equatable {
  const CountNewMessageState();

  @override
  List<Object> get props => [];
}

class CountNewMessageInitial extends CountNewMessageState {}

class CountNewMessageLoad extends CountNewMessageState {}

class CountNewMessageloaded extends CountNewMessageState {}

class ChatstateOpen extends CountNewMessageState {}

class Chatstateclose extends CountNewMessageState {}
