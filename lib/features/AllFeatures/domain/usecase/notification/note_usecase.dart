import 'package:dartz/dartz.dart';
import 'package:university/core/error/failure.dart';
import 'package:university/features/AllFeatures/domain/entites/notification_enitites.dart';
import 'package:university/features/AllFeatures/domain/repositories/notification/notification_repository.dart';

class GetAllNotifications {
  final NotificationRepository repository;

  GetAllNotifications({required this.repository});

  Future<Either<Failure, List<Notifications>>> call() async {
    return await repository.getAllNotifications();
  }
}
