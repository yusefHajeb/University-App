import 'package:university/storge_perf..dart';

class Global {
  static late StorgeServece storgeServece;
  static Future init() async {
    storgeServece = await StorgeServece().init();
  }
}
