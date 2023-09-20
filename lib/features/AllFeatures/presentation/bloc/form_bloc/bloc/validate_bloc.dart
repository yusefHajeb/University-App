import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'validate_event.dart';
part 'validate_state.dart';

class ValidateBloc extends Bloc<ValidateEvent, ValidateState> {
  ValidateBloc() : super(ValidateInitial()) {
    on<ValidateEvent>((event, emit) {
      if (event is ValidateEvent) {
        emit(ValidateState(isValid: event.ckeck));
      }
    });
  }
}
