import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:university/chat/data/remote/data_sources/storage_provider.dart';
import 'package:university/chat/data/remote/models/student_model.dart';
import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/presentation/cubit/user/user_cubit.dart';
import 'package:university/chat/presentation/widgets/common.dart';
import 'package:university/chat/presentation/widgets/profile_widget.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';

class ProfilePage extends StatefulWidget {
  final StudentEntity uid;

  const ProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController? _nameController;
  TextEditingController? _statusController;
  TextEditingController? _emailController;
  TextEditingController? _numController;
  TextEditingController? _recordController;

  File? _image;
  String? _profile;
  String? _username;
  String? _phoneNumber;
  final picker = ImagePicker();

  @override
  void dispose() {
    _nameController!.dispose();
    _statusController!.dispose();
    _emailController!.dispose();
    _numController!.dispose();
    _recordController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _nameController = TextEditingController(text: "");
    _statusController = TextEditingController(text: "");
    _emailController = TextEditingController(text: "");
    _numController = TextEditingController(text: "");
    _recordController = TextEditingController(text: "");
    super.initState();
  }

  Future getImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          StorageProviderRemoteDataSource.uploadFile(file: _image!)
              .then((value) {
            print("profileUrl");
            setState(() {
              _profile = value;
            });
          });
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      toast("error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          return _profileWidget(userState.users);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _profileWidget(List<StudentEntity> users) {
    final user = users.firstWhere((user) => user.t_id == widget.uid.t_id,
        orElse: () => StudentModel());
    _nameController!.value = TextEditingValue(text: user.std_name);
    _emailController!.value = TextEditingValue(text: user.std_email);
    _statusController!.value = TextEditingValue(text: user.status);
    _recordController!.value = TextEditingValue(text: "${user.std_phone}");

    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Container(
          decoration: BoxDecoration(
              color: BodyColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                  height: 62,
                  width: 62,
                  decoration: BoxDecoration(
                    color: color747480,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child:
                        profileWidget(imageUrl: user.std_image, image: _image),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                'Remove profile photo',
                style: TextStyle(
                    color: greenColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 28,
              ),
              Container(
                margin: const EdgeInsets.only(left: 22, right: 22),
                height: 47,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: color747480.withOpacity(.2),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  controller: _nameController,
                  onChanged: (textData) {
                    _username = textData;
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    hintText: 'username',
                    hintStyle:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 22, right: 22),
                height: 47,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: color747480.withOpacity(.2),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: AbsorbPointer(
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.grey,
                      ),
                      hintText: 'email',
                      hintStyle:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 22, right: 22),
                height: 47,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: color747480.withOpacity(.2),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: AbsorbPointer(
                  child: TextField(
                    controller: _recordController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.grey,
                      ),
                      hintText: 'phone',
                      hintStyle:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 22, right: 22),
                height: 47,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: color747480.withOpacity(.2),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: AbsorbPointer(
                  child: TextField(
                    controller: _recordController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.numbers,
                        color: Colors.grey,
                      ),
                      hintText: 'record',
                      hintStyle:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 22, right: 22),
                height: 47,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: color747480.withOpacity(.2),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  controller: _statusController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.stacked_bar_chart_rounded,
                      color: Colors.grey,
                    ),
                    hintText: 'status',
                    hintStyle:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              const Divider(
                thickness: 1,
                endIndent: 15,
                indent: 15,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  _updateProfile();
                },
                child: Container(
                    margin: const EdgeInsets.only(left: 22, right: 22),
                    alignment: Alignment.center,
                    height: 44,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    )),
              ),
              const SizedBox(
                height: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateProfile() {
    // BlocProvider.of<UserCubit>(context).getUpdateUser(
    //   user: UserEntity(
    //     uid: widget.uid,
    //     name: _nameController!.text,
    //     status: _statusController!.text,
    //     profile: _profile!,
    //   ),
    // );
    toast("Profile Updated");
  }
}
