part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatLoading extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatLoaded extends ChatState {
  final List<TextMessageEntity> messages;

  ChatLoaded({required this.messages});
  @override
  List<Object> get props => [messages];
}

class ChatRef extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatFailure extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatErrorState extends ChatState {
  final String message;

  const ChatErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class SendTextMessageSuccess extends ChatState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SendFileMessageSuccess extends ChatState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
