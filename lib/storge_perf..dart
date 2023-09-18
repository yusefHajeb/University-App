import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/core/constant/varibal.dart';

import 'app/enjection_container.dart' as di;
import 'features/AllFeatures/presentation/helpers/bloc_observer.dart';

class StorgeServece {
  late final SharedPreferences _pref;
  Future<StorgeServece> init() async {
    await di.init();
    _pref = di.sl<SharedPreferences>();
    // _pref = await SharedPreferences.getInstance();
    Bloc.observer = MyBlocObserver();

    return this;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _pref.setBool(key, value);
  }

  bool getDeviceFirstOpen() {
    return _pref.getBool(Constants.STORGE_DEVICE_OPEN_FIRST_TIME) ?? false;
  }

  bool getLogedUsersFirstSuccess() {
    return _pref.getBool(Constants.STORGE_USER_LOGED_FIRST) ?? false;
  }
}
