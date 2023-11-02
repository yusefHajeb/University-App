import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/core/error/execptions.dart';
import 'package:university/features/AllFeatures/data/models/schedule_model.dart';

import '../../../../../core/constant/varibal.dart';

abstract class ScheduleLocalDataSource {
  Future<List<SchedulModel>> getCachedSchedul();
  Future<Unit> cacheSchedul(List<SchedulModel> schedulModel);
  Future<Unit> cacheSchedulNotifiction(SchedulModel schedulModel);
  Future<Unit> cachedLetctersToday(List<SchedulModel> schedulModel);
  Future<List<SchedulModel>> getCachedLetchers(String date);
}

class ScheduleLocalDataSourceImp implements ScheduleLocalDataSource {
  final SharedPreferences sharedPreferences;

  ScheduleLocalDataSourceImp({required this.sharedPreferences});
  @override
  Future<Unit> cacheSchedul(List<SchedulModel> schedulModel) async {
    final schedulModelToJson = await schedulModel
        .map<Map<String, dynamic>>((schedul) => schedul.toJson())
        .toList();
    sharedPreferences.setString(
        Constants.cachedSchedule, json.encode(schedulModelToJson));

    return Future.value(unit);
  }

  @override
  Future<List<SchedulModel>> getCachedSchedul() {
    print("Get data Schedule from ShardPrefrance");
    final jsonString = sharedPreferences.getString(Constants.cachedSchedule);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<SchedulModel> jsonToSchedulModel = decodeJsonData
          .map<SchedulModel>((jsonData) => SchedulModel.formJson(jsonData))
          .toList();

      return Future.value(jsonToSchedulModel);
    } else {
      throw EmptyCasheException();
    }
  }

  @override
  Future<Unit> cacheSchedulNotifiction(SchedulModel schedulModel) async {
    final schedulModelToJson = await schedulModel.toJson();

    sharedPreferences.setString(
        Constants.cachedSchedule, json.encode(schedulModelToJson));

    return Future.value(unit);
  }

  @override
  Future<Unit> cachedLetctersToday(List<SchedulModel> schedulModel) async {
    // final schedulModelToJson = await schedulModel
    //     .map<Map<String, dynamic>>((schedul) => schedul.toJson())
    //     .toList();

    final jsonString = sharedPreferences.getString(Constants.cachedLetchers);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<SchedulModel> extractDataLetchers = decodeJsonData
          .map<SchedulModel>((jsonData) => SchedulModel.formJson(jsonData))
          .toList();
      schedulModel.forEach((element) {
        extractDataLetchers.add(element);
      });
//===============
      final letchersToJson = await extractDataLetchers
          .map<Map<String, dynamic>>((schedul) => schedul.toJson())
          .toList();
      sharedPreferences.setString(
          Constants.cachedLetchers, json.encode(letchersToJson));
      return Future.value(unit);
    } else {
      final schedulModelToJson = await schedulModel
          .map<Map<String, dynamic>>((schedul) => schedul.toJson())
          .toList();
      sharedPreferences.setString(
          Constants.cachedLetchers, json.encode(schedulModelToJson));
      return Future.value(unit);
    }
  }

  @override
  Future<List<SchedulModel>> getCachedLetchers(String dateDay) {
    print("Get data Letchers from ShardPrefrance");
    final jsonString = sharedPreferences.getString(Constants.cachedLetchers);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<SchedulModel> jsonToSchedulModel =
          decodeJsonData.map<SchedulModel>((jsonData) {
        if (SchedulModel.formJson(jsonData).date ==
            "${DateTime.now().year} / $dateDay") ;
        return SchedulModel.formJson(jsonData);
      }).toList();

      return Future.value(jsonToSchedulModel);
    } else {
      throw EmptyCasheException();
    }
  }
}
