import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/features/AllFeatures/domain/usecase/ScheduleUsecae/get_all_schedule.dart';
import 'package:university/features/AllFeatures/domain/usecase/ScheduleUsecae/notificatin_schedule_usecase.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/function/failure_to_message.dart';
import '../../../domain/entites/schedule.dart';

import '../../../domain/entites/schedule.dart';

part 'schedul_event.dart';
part 'schedul_state.dart';

class SchedulBloc extends Bloc<SchedulEvent, SchedulState> {
  final GetAllScheduleUsecase getAllScheduleUsecase;
  // final GetNotificationScheduleUsecase schedlulenotificationUsecae;
  SchedulBloc({required this.getAllScheduleUsecase}) : super(SchedulInitial()) {
    on<SchedulEvent>((event, emit) async {
      if (event is GetAllScheduleEvent) {
        // emit(LoadingSchedulState());
        print("========================");

        var cahsed = [
          Schedule(
              batch: "1",
              classroom: 'ds',
              instructor: "Rasheed",
              coures: " Prograaming",
              days: "Thrusday"),
          Schedule(
              batch: "1",
              classroom: 'ds',
              instructor: "Rasheed",
              coures: " Prograaming",
              days: "Thrusday"),
        ];

        // final schedulOrError = await getAllScheduleUsecase();
        // schedulOrError.fold(
        //   (failure) =>
        //       emit(ErrorSchedulState(message: failureToMessage(failure))),
        //   (schedula) => emit(LoadedSchedulState(schedule: schedula)),
        // );
        emit(LoadedSchedulState(schedule: cahsed));
        // emit(_failureOrSchedualToState(schedulOrError));
      } else if (event is RefreshScheduleEvent) {
        print("----------------- Refreshe");
        emit(LoadingSchedulState());
        final schedulOrError = await getAllScheduleUsecase();
        emit(_failureOrSchedualToState(schedulOrError));
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
      Either<Failure, List<Schedule>> either) {
    return either.fold(
      (failure) => ErrorSchedulState(message: failureToMessage(failure)),
      (schedula) => LoadedSchedulState(schedule: schedula),
    );
  }
}
