import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/features/AllFeatures/domain/usecase/ScheduleUsecae/get_all_schedule.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/function/failure_to_message.dart';
import '../../../domain/entites/schedule.dart';
part 'schedul_event.dart';
part 'schedul_state.dart';

late Either<Failure, List<Schedule>> schedulOrError;

class SchedulBloc extends Bloc<SchedulEvent, SchedulState> {
  final GetAllScheduleUsecase getAllScheduleUsecase;
  // final GetNotificationScheduleUsecase schedlulenotificationUsecae;
  SchedulBloc({required this.getAllScheduleUsecase}) : super(SchedulInitial()) {
    on<SchedulEvent>((event, emit) async {
      if (event is GetAllScheduleEvent) {
        emit(LoadingSchedulState());

        // ignore: unused_local_variable

        schedulOrError = await getAllScheduleUsecase();
        emit(_failureOrSchedualToState(schedulOrError, event.index));
      } else if (event is RefreshScheduleEvent) {
        print("----------------- Refreshe");
        emit(LoadingSchedulState());
        final schedulOrError = await getAllScheduleUsecase();
        emit(_failureOrSchedualToState(schedulOrError, 0));
      } else if (event is SelectDayScheduleEvent) {
        emit(LoadingSchedulState());
        emit(_failureOrSchedualToState(schedulOrError, event.index));
      }

      // else if (event is NotificationScheduleEvent) {
      //   emit(LoadingSchedulState());
      //   final notification = await schedlulenotificationUsecae();
      //   notification.fold(
      //     (failure) => ErrorSchedulState(message: failureToMessage(failure)),
      //     (schedula) => NotificationScheduleState(schedule: schedula),
      //   );
      // }
    });
  }
  SchedulState _failureOrSchedualToState(
      Either<Failure, List<Schedule>> either, int index) {
    return either.fold(
      (failure) => ErrorSchedulState(message: failureToMessage(failure)),
      (schedula) => LoadedSchedulState(schedule: schedula, index: index),
    );
  }
}
