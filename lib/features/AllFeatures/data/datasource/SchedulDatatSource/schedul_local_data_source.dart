import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/core/error/execptions.dart';
import 'package:university/features/AllFeatures/data/models/schedule_model.dart';

abstract class SchedulLocalDataSource {
  Future<List<SchedulModel>> getCachedSchedul();
  Future<Unit> cacheSchedul(List<SchedulModel> schedulModel);
}

class ScedulLocaldataSourceImp implements SchedulLocalDataSource {
  final SharedPreferences sharedPreferences;

  ScedulLocaldataSourceImp({required this.sharedPreferences});
  @override
  Future<Unit> cacheSchedul(List<SchedulModel> schedulModel) async {
    final schedulModelToJson = await schedulModel
        .map<Map<String, dynamic>>((schedul) => schedul.toJson())
        .toList();
    sharedPreferences.setString(
        "CACHED_SCHEDUL", json.encode(schedulModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<SchedulModel>> getCachedSchedul() {
    final jsonString = sharedPreferences.getString("CACHED_SCHEDUL");
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
}
