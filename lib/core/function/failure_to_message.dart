import '../error/failure.dart';
import '../string/failure_message.dart';

String failureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return serverFailureMessage;
    case EmptyCasheFailure:
      return emptyCacheFailureMessage;
    case OffLineFailure:
      return offlineFailureMessage;
    case SingInFailure:
      return singInError;
    case SingUpFailure:
      return singInError;
    default:
      return "Unexpected Error, Please try again later.";
  }
}
