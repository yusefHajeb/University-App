import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(ServicesInitial()) {
    on<ServicesEvent>((event, emit) {
      if (event is ServiceCurentEvent) {
        emit(ServiceCurentState(cureent: state.curent));
        state.leftCurent = changePostionedOfLine(state.curent);
        emit(ServiceLineUnderTab(index: changePostionedOfLine(state.curent)));
      }
    });
  }
}

int changePostionedOfLine(int index) {
  switch (index) {
    case 0:
      return 0;
    case 1:
      return 50;
    case 2:
      return 100;
    case 3:
      return 200;
    case 4:
      return 260;
    default:
      return 0;
  }
}
