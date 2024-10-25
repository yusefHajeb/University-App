import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:university/chat/data/remote/data_sources/DataAccess.dart';
import 'package:university/chat/domain/entities/group_entity.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/domain/use_cases/get_all_group_usecase.dart';
import 'package:university/chat/domain/use_cases/update_group_usecase.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  final GetAllGroupsUseCase getAllGroupsUseCase;
  final UpdateGroupUseCase groupUseCase;
  GroupCubit({required this.groupUseCase, required this.getAllGroupsUseCase})
      : super(GroupInitial());
  StreamSubscription<List<GroupEntity>>? streamSubscription;
  Future<void> getGroups(int batch_id) async {
    emit(GroupLoading());
    try {
      final streamResponse = getAllGroupsUseCase.call(batch_id);
      streamSubscription = streamResponse.listen((groups) {
        emit(GroupLoaded(groups: groups));
      });
      // if (await new DataAccessCrud().checkServerConnection()) {
      //   Timer.periodic(Duration(milliseconds: 800), (timer) async {
      //     final streamResponse = getAllGroupsUseCase.call();
      //     streamSubscription = streamResponse.listen((groups) {
      //       emit(GroupLoaded(groups: groups));
      //     });
      //   });
      // }
    } catch (rd) {
      // final streamResponse = getAllGroupsUseCase.call();
      // streamSubscription = streamResponse.listen((groups) {
      //   emit(GroupLoaded(groups: groups));
      // });
    }
  }

  // Future<void> getCreateGroup({required GroupEntity groupEntity}) async {
  //   try {
  //     await getCreateGroupUseCase.call(groupEntity);
  //   } on SocketException catch (_) {
  //     emit(GroupFailure());
  //   } catch (_) {
  //     emit(GroupFailure());
  //   }
  // }

  Future<void> updateGroupLastMessageWhenSend(
      {required GroupEntity groupEntity}) async {
    try {
      if (state is GroupLoaded) {
        final List<GroupEntity> updatedgroup =
            (state as GroupLoaded).groups.toList();
        final int messageIndex = updatedgroup
            .indexWhere((group) => group.groupId == groupEntity.groupId);
        if (messageIndex != -1) {
          updatedgroup[messageIndex] = groupEntity;
        } else {
          updatedgroup.add(groupEntity);
        }
        emit(GroupLoaded(groups: updatedgroup));
      }
    } on SocketException catch (_) {
      emit(GroupFailure());
    } catch (_) {
      emit(GroupFailure());
    }
  }

  Future<void> refreshGroup() async {
    try {
      if (state is GroupLoaded) {
        final streamResponse = getAllGroupsUseCase.call(12);
        streamSubscription = streamResponse.listen((groups) {
          emit(GroupLoaded(groups: groups));
        });
      }
    } on SocketException catch (_) {
      emit(GroupFailure());
    } catch (_) {
      emit(GroupFailure());
    }
  }
}
