import 'package:dartz/dartz.dart';
import 'package:university/core/error/failure.dart';

import '../../entites/notification_enitites.dart';
// import 'package:flutter/widgets.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<Notifications>>> getAllNotifications();
}
