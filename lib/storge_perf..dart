import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/network/check_network.dart';
import 'app/enjection_container.dart' as di;
import 'features/AllFeatures/presentation/helpers/bloc_observer.dart';

class StorgeServece {
  // late final Hive hive;
  late final SharedPreferences _pref;
  late final Directory libraryDirectory;
  // late BuildContext context;
  late NetworkInfo _network;
  Future<StorgeServece> init() async {
    // await Hive.initFlutter();

    await di.init();
    // _network = di.sl<NetworkInfoImp>();
    _pref = di.sl<SharedPreferences>();
    // context = di.sl<BuildContext>();
    // _pref = await SharedPreferences.getInstance();
    Bloc.observer = MyBlocObserver();
    libraryDirectory = await getApplicationDocumentsDirectory();
    return this;
  }

  Future<bool> checkNetWork() async {
    return await _network.isConnected;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _pref.setBool(key, value);
  }

  Future<bool> clear() async {
    return await _pref.clear();
  }

  Future<bool> getBool(String key) async {
    return await _pref.getBool(key) ?? false;
  }

  bool getDeviceFirstOpen() {
    return _pref.getBool(Constants.STORGE_DEVICE_OPEN_FIRST_TIME) ?? false;
  }

  bool getLogedUsersFirstSuccess() {
    return _pref.getBool(Constants.STORGE_USER_LOGED_FIRST) ?? false;
  }

  String? getStringData(String request) {
    return _pref.getString(request);
  }

  void setString(String response, String value) {
    _pref.setString(response, value);
  }

  downloadBook(String libraryPath, String urlBook) async {
    try {
      await Dio().download(urlBook, libraryPath,
          onReceiveProgress: (received, total) {
        if (total != -1) {
          print((received / total * 100).toStringAsFixed(0) + "%");
        }
      });
    } on DioException catch (e) {
      print(e.message);
    }
  }

  String getPathStorageLibrary() {
    return libraryDirectory.path;
  }
  // Future<void> setDataToBox<T>(String boxName, T myClass) async {
  //   final box = await Hive.openBox<T>('$boxName');
  //   await box.add(myClass);
  //   await box.close();
  // }

  // Future<List<T>> retrieveData<T>(String boxName) async {
  //   final box = await Hive.openBox<T>('$boxName');
  //   final data = box.values.toList();
  //   await box.close();
  //   return data;
  // }
  // BuildContext getContext() {
  //   return context;
  // }
}
