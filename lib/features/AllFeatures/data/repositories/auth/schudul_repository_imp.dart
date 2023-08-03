// import 'package:university/core/error/execptions.dart';
// import 'package:university/features/AllFeatures/data/models/schedule_model.dart';
// import 'package:university/features/AllFeatures/domain/entites/schedule.dart';
// import 'package:university/core/error/failure.dart';
// import 'package:dartz/dartz.dart';
// import 'package:university/features/AllFeatures/domain/repositories/schedule_repository.dart';
// import 'package:university/core/network/check_network.dart';

// import '../../datasource/ScheduleDataSource/schedul_local_data_source.dart';
// import '../../datasource/ScheduleDataSource/shedul_remote_datasource.dart';

// class SchedulRepositoryImp implements ScheduleRepository {
//   final SchedulRemoteDataSource remoteSchedul;
//   final ScheduleLocalDataSource localSource;
//   final NetworkInfo networkInfo;
//   SchedulRepositoryImp({
//     required this.networkInfo,
//     required this.remoteSchedul,
//     required this.localSource,
//   });
//   @override
//   Future<Either<Failure, List<Schedule>>> getALLSchedule() async {
//     if (await networkInfo.isConnected) {
//       try {
//         final List<SchedulModel> remoteData =
//             await remoteSchedul.getAllSchedul();
//         localSource.cacheSchedul(remoteData);
//         return Right(remoteData);
//       } on ServerException {
//         return Left(ServerFailure());
//       }
//     } else {
//       try {
//         final List<SchedulModel> localData =
//             await localSource.getCachedSchedul();
//         return Right(localData);
//       } on EmptyCasheException {
//         return Left(EmptyCasheFailure());
//       }
//     }
//   }

//   @override
//   Future<Either<Failure, Schedule>> getNotification() async {
//     if (await networkInfo.isConnected) {
//       try {
//         final SchedulModel remoteData =
//             await remoteSchedul.getScheduleNotification();
//         localSource.cacheSchedulNotifiction(remoteData);
//         return Right(remoteData);
//       } on ServerException {
//         return Left(ServerFailure());
//       }
//     } else {
//       return Left(EmptyCasheFailure());
//     }
//     // } else {
//     //   try {

//     //   } on EmptyCasheException {
//     //     return Left(EmptyCasheFailure());
//     //   }
//     // }
//   }
// }
