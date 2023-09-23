import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/network/check_network.dart';

import 'app/enjection_container.dart' as di;
import 'features/AllFeatures/presentation/helpers/bloc_observer.dart';

class StorgeServece {
  late final SharedPreferences _pref;
  // late BuildContext context;
  late NetworkInfo _network;
  Future<StorgeServece> init() async {
    await di.init();
    _network = di.sl<NetworkInfoImp>();
    _pref = di.sl<SharedPreferences>();
    // context = di.sl<BuildContext>();
    // _pref = await SharedPreferences.getInstance();
    Bloc.observer = MyBlocObserver();

    return this;
  }

  Future<bool> checkNetWork() async {
    return await _network.isConnected;
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

  // BuildContext getContext() {
  //   return context;
  // }
}
