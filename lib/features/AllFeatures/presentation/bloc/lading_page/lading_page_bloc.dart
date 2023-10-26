import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'lading_page_event.dart';
part 'lading_page_state.dart';

class LadingPageBloc extends Bloc<LadingPageEvent, LadingPageState> {
  LadingPageBloc() : super(LadingPageInitial(tabIndex: 0)) {
    on<LadingPageEvent>((event, emit) {
      if (event is TabChange) {
        emit(LadingPageState(tabIndex: event.tabIndex));
      } else {
        emit(LadingPageState(tabIndex: 1));
      }
    });
  }
}
