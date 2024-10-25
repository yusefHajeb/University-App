import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/domain/use_cases/get_all_users_usecase.dart';
import 'package:university/chat/domain/use_cases/get_update_user_usecase.dart';

import '../../../domain/entities/student_entity.dart';
import '../../../domain/use_cases/get_update_user_usecase.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetAllUsersUseCase getAllUsersUseCase;
  final GetUpdateUserUseCase getUpdateUserUseCase;
  UserCubit(
      {required this.getAllUsersUseCase, required this.getUpdateUserUseCase})
      : super(UserInitial());

  Future<void> getUsers(int batch_id) async {
    emit(UserLoading());
    final streamResponse = getAllUsersUseCase.call(batch_id);
    print(streamResponse.toString());
    streamResponse.listen((users) {
      emit(UserLoaded(users: users));
    });
  }

  Future<void> getUpdateUser({required StudentEntity user}) async {
    try {
      await getUpdateUserUseCase.call(user);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
