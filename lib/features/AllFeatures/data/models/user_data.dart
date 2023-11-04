import 'dart:convert';

import 'package:university/features/AllFeatures/data/models/auth_models/singup_model.dart';

import '../../../../core/constant/varibal.dart';
import '../../../../core/value/global.dart';

SingUpModel userDataModel() {
  final jsonString = Global.storgeServece.getStringData(Constants.userData);

  late SingUpModel student;
  if (jsonString != null) {
    final decodeJsonData = json.decode(jsonString);
    student = SingUpModel.formJson(decodeJsonData);
    return student;
  }

  return SingUpModel(
      name: "name", image: "", username: "username", phone: "771274299");
}
