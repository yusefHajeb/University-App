import 'package:dartz/dartz.dart';
import 'package:university/core/error/execptions.dart';
import 'package:university/core/error/failure.dart';
import 'package:university/core/network/check_network.dart';
import 'package:university/features/AllFeatures/data/datasource/notification/notification_local.dart';
import 'package:university/features/AllFeatures/data/datasource/notification/ontification_remote.dart';
import 'package:university/features/AllFeatures/domain/repositories/notification/notification_repository.dart';
import 'package:university/main.dart';

import '../../../domain/entites/notification_enitites.dart';

class NotificationRepositoryImp implements NotificationRepository {
  final NotificationsRemote remote;
  final NotificationsLocal local;
  final NetworkInfo networkInfo;

  NotificationRepositoryImp(
      {required this.remote, required this.local, required this.networkInfo});

  @override
  Future<Either<Failure, List<Notifications>>> getAllNotifications() async {
    if (await socket.connected) {
      try {
        var dataRepository = await remote.getNotification();
        local.cachedNotifications(dataRepository);
        return Right(dataRepository);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localed = await local.getNotifications();

        return Right(localed);
      } on EmptyCasheException {
        return Left(EmptyCasheFailure());
      }
    }
  }
}
