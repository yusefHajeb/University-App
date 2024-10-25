import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/chat/domain/use_cases/Count_number_noseen_usecase.dart';

part 'count_new_message_state.dart';

class CountNewMessageCubit extends Cubit<CountNewMessageState> {
  final CountnumberNoseenUsecase countnumberNoseenUsecase;
  final SharedPreferences prefs;
  CountNewMessageCubit({
    required this.countnumberNoseenUsecase,
    required this.prefs,
  }) : super(CountNewMessageInitial());
  static CountNewMessageCubit getcubit(BuildContext context) {
    return BlocProvider.of(context);
  }

  int count_messag_no_seen = 0;
  bool isOpen = false;

  void get_count_messag_no_seen() async {
    //ChangeStateChat();
    if (isOpen == false) {
      print("get_count_messag_no_seen");
      count_messag_no_seen = await countnumberNoseenUsecase.call();
    } else
      count_messag_no_seen = 0;
    emit(CountNewMessageloaded());
  }

  void ref_count_messag_no_seen() {
    count_messag_no_seen = 0;
    emit(CountNewMessageLoad());
  }

  void ChangeStateChat() async {
    isOpen = !isOpen;
    print(isOpen);
    if (isOpen) {
      await prefs.setInt("rowCount", 0);
      emit(ChatstateOpen());
    } else {
      emit(Chatstateclose());
    }
  }
}
