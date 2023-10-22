import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:university/features/AllFeatures/domain/usecase/ScheduleUsecae/get_all_schedule.dart';
import 'package:university/features/AllFeatures/presentation/bloc/search_books/search_books_bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/function/failure_to_message.dart';
import '../../../domain/entites/schedule.dart';
part 'schedul_event.dart';
part 'schedul_state.dart';

late Either<Failure, List<Schedule>> schedulOrError;

class ScheduleBloc extends Bloc<SchedulEvent, ScheduleState> {
  final GetAllScheduleUsecase getAllScheduleUsecase;
  // final GetNotificationScheduleUsecase schedlulenotificationUsecae;
  ScheduleBloc({required this.getAllScheduleUsecase})
      : super(SchedulInitial()) {
    on<SelectDayScheduleEvent>(_selectDayScheduleEvent);
    on<GetAllScheduleEvent>(_getAllScheduleEvent);
    on<RefreshScheduleEvent>(_refreshScheduleEvent);

    // on<SchedulEvent>((event, emit) async {
    //   if (event is GetAllScheduleEvent) {
    //     emit(LoadingSchedulState());

    //     // ignore: unused_local_variable

    //     schedulOrError = await getAllScheduleUsecase();
    //     // emit(_failureOrSchedualToState(schedulOrError, 0, ''));
    //     emit(_failureOrSchedualToState(
    //         schedulOrError,
    //         int.parse(DateFormat('dd').format(DateTime.now())),
    //         DateFormat('EEEE', 'ar').format(
    //             DateTime(DateTime.now().year, DateTime.now().month, 12))));
    //   } else if (event is SelectDayScheduleEvent) {
    //     emit(_failureOrSchedualToState(schedulOrError, event.index, event.day));
    //   } else if (event is RefreshScheduleEvent) {
    //     print("----------------- Refreshe");
    //     emit(LoadingSchedulState());
    //     final schedulOrError = await getAllScheduleUsecase();
    //     emit(_failureOrSchedualToState(schedulOrError, 0, ''));
    //   }

    //   // else if (event is NotificationScheduleEvent) {
    //   //   emit(LoadingSchedulState());
    //   //   final notification = await schedlulenotificationUsecae();
    //   //   notification.fold(
    //   //     (failure) => ErrorSchedulState(message: failureToMessage(failure)),
    //   //     (schedula) => NotificationScheduleState(schedule: schedula),
    //   //   );
    //   // }
    // });
  }
  void _selectDayScheduleEvent(
    SelectDayScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(_failureOrSchedualToState(schedulOrError, event.index, event.day));
  }

  Future<void> _getAllScheduleEvent(
    GetAllScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(LoadingSchedulState());
    schedulOrError = await getAllScheduleUsecase();
    emit(_failureOrSchedualToState(
        schedulOrError,
        int.parse(DateFormat('dd').format(DateTime.now())),
        DateFormat('EEEE', 'ar')
            .format(DateTime(DateTime.now().year, DateTime.now().month, 12))));
  }

  Future<void> _refreshScheduleEvent(
    RefreshScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(LoadingSchedulState());
    schedulOrError = await getAllScheduleUsecase();
    emit(_failureOrSchedualToState(
        schedulOrError,
        int.parse(DateFormat('dd').format(DateTime.now())),
        DateFormat('EEEE', 'ar')
            .format(DateTime(DateTime.now().year, DateTime.now().month, 12))));
  }

  ScheduleState _failureOrSchedualToState(
      Either<Failure, List<Schedule>> either, int index, String day) {
    return either.fold(
        (failure) => ErrorSchedulState(message: failureToMessage(failure)),
        (schedula) {
      // print("days");
      // print(day.toString());
      // print("in failure print");
      // print(schedula.where((element) => element.days == day).toList());
      // List<Schedule> cash =
      //     schedula.where((element) => element.days == day).toList();
      return LoadedSchedulState(schedule: schedula, index: index, day: day);
    });
  }
}
