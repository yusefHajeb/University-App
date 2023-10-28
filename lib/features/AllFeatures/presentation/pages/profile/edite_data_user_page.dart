import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/constant/varibal.dart';
import 'package:university/core/value/app_space.dart';
import 'package:university/core/value/global.dart';
import 'package:university/features/AllFeatures/domain/entites/auth_entites/singup.dart';
import 'package:university/features/AllFeatures/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:university/features/AllFeatures/presentation/pages/application_page.dart';
import '../../../../../core/color/app_color.dart';
import '../../../../../core/widget/bakground_dark.dart';
import '../../../../../core/widget/buttons/default_back.dart';
import '../../../../../core/widget/custom_input.dart';
import '../../../../../core/widget/dummy/image_net.dart';
import '../../../../../core/widget/dummy/profile_dummy.dart';
import '../../../data/models/auth_models/singup_model.dart';
import '../../../data/models/user_data.dart';
import '../../bloc/lading_page/lading_page_bloc.dart';

class EditeUserData extends StatefulWidget {
  const EditeUserData({super.key});

  @override
  State<EditeUserData> createState() => _EditeUserDataState();
}

class _EditeUserDataState extends State<EditeUserData> {
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _name.text = student.name.toString();
    _password.text = student.password ?? "";
    _phone.text = student.phone ?? "";
    _gmail.text = student.email ?? "";

    // TODO: implement initState
    super.initState();
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SingUpModel student = userDataModel();

  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _gmail = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _image = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TextEditingController _p = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.backgroundPages,
      body: Container(
        child: Stack(
          children: [
            DarkRadialBackground(
              color: AppColors.backgroundPages,
              position: "topLeft",
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AppSpaces.verticalSpace20,
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const DefaultNav(
                                  type: ProfileDummyType.image,
                                  title: "\t\t\t تعديل الملف الشخصي")),
                          AppSpaces.verticalSpace20,
                          ProfileDummyNet(
                              color: HexColor.fromHex("94F0F1"),
                              dummyType: ProfileDummyTypeNet.image,
                              scale: 4.0,
                              image: student.image),
                          LabelledFormInput(
                              hint: student.name ?? "",
                              controller: _name,
                              label: "الاسم",
                              placeholder: student.name.toString()),
                          Container(
                            child: LabelledFormInput(
                              controller: _password,
                              hint: student.password?.toString() ?? "",
                              label: "كلمة السر",
                              placeholder: student.password.toString(),
                              isNumber: true,
                            ),
                          ),
                          Container(
                            child: LabelledFormInput(
                              controller: _phone,
                              hint: student.phone ?? "",
                              label: "رقم الهاتف",
                              placeholder: "${student.phone}",
                              isNumber: true,
                            ),
                          ),
                          AppSpaces.verticalSpace20,
                          LabelledFormInput(
                            controller: _gmail,
                            hint: student.email ?? "",
                            label: "الايميل",
                            placeholder: "",
                            isNumber: false,
                          ),
                          AppSpaces.verticalSpace10,
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: validationButtonUpdate,
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.kCardColor),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(200.0),
                                  ))),
                              child: Text("تعديل"),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(15.0),
                          //   child: OutlinedButtonWithText(
                          //       width: double.infinity,
                          //       content: "تعديل",
                          //       onPressed: () {
                          //         // Navigator.push(
                          //         //     context,
                          //         //     MaterialPageRoute(
                          //         //       builder: (_) => const EditeUserData(),
                          //         //     ));
                          //         // Get.to(() => EditProfilePage());
                          //       }),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validationButtonUpdate() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final SingUp user = SingUp(
          email: _gmail.text,
          name: _name.text,
          phone: _phone.text,
          image: _image.text,
          password: _password.text);
      print(user);
      dynamic jsonUser = Global.storgeServece.getStringData(Constants.userData);
      dynamic decode = json.decode(jsonUser);

      SingUp dataCashed = SingUpModel.formJson(decode);

      SingUp data = dataCashed.copyWith(
        name: _name.text,
        email: _gmail.text,
        phone: _phone.text,
        password: _password.text,
        record: student.record,
      );

      print("this data after update and i will cashed");
      print(data);
      Global.storgeServece.setString(Constants.userData, json.encode(data));
      // Global.storgeServece
      //     .setString(Constants.userData, json.encode(dataCashed));
      context.read<AuthenticationBloc>().add(UpdateDataUser(user: data));

      jsonUser = Global.storgeServece.getStringData(Constants.userData);
      decode = jsonDecode(jsonUser);

      dataCashed = SingUpModel.formJson(decode);
      print("dataCashed");
      print(dataCashed);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ApplicationPage()));
      context.read<LadingPageBloc>().add(TabChange(4));

      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return Container(
      //         width: 200,
      //         height: 200,
      //         color: Colors.white,
      //       );
      //     });
    }
  }
}
