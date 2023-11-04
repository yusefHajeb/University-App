import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:university/features/AllFeatures/domain/entites/notification_enitites.dart';
import 'package:university/features/AllFeatures/domain/usecase/notification/note_usecase.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/function/failure_to_message.dart';

part 'notefications_event.dart';
part 'notefications_state.dart';

late Either<Failure, List<Notifications>> dataOrFailuer;

class NotificationsBloc extends Bloc<NoteficationsEvent, NotificationsState> {
  GetAllNotifications getAllNotifications;
  NotificationsBloc({required this.getAllNotifications})
      : super(NoteficationsInitial()) {
    on<GetNotifications>(_getNotifications);
  }

  Future<void> _getNotifications(
    GetNotifications event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(LoadingNotifications());
    dataOrFailuer = await getAllNotifications();
    dataOrFailuer.fold((failure) {
      return ErrorNotifications(errorMessage: failureToMessage(failure));
    }, (response) {
      return LoadedNotifications(notifications: response);
    });
  }
}
