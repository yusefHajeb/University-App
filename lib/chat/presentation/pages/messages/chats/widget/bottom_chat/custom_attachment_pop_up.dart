import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university/chat/domain/entities/single_chat_entity.dart';
import 'package:university/chat/presentation/pages/messages/chats/preview/document_preview_page.dart';
import 'package:university/chat/presentation/pages/messages/chats/preview/image_preview_page.dart';
import 'package:university/chat/presentation/widgets/theme/style.dart';
import 'package:university/generated/image_griphy_picker.dart';

class CustomAttachmentPopUp extends StatelessWidget {
  final SingleChatEntity singleChatEntity;

  const CustomAttachmentPopUp({Key? key, required this.singleChatEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        CupertinoIcons.ellipsis_vertical,
        color: greenColor,
        size: 20,
      ),
      //this allows you to specify the position of the popup menu relative to its anchor point
      offset: const Offset(0, -160),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      constraints: const BoxConstraints.tightFor(width: double.infinity),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            padding: const EdgeInsets.only(left: 30, right: 40, bottom: 15),
            enabled: false,
            onTap: () {},
            child: Wrap(
              spacing: 8,
              runAlignment: WrapAlignment.spaceAround,
              children: [
                AttachmentCardItem(
                  name: "مستند",
                  color: Colors.deepPurpleAccent,
                  icon: Icons.insert_drive_file,
                  onPress: () {
                    pickFileDocument(context);
                  },
                ),
                AttachmentCardItem(
                  name: "الكيمرة",
                  color: Colors.redAccent,
                  icon: Icons.camera_alt,
                  onPress: () {
                    // Navigator.pushNamed(
                    //     context,
                    //     CameraPage.routeName,
                    //     arguments: CameraPage(
                    //       receiverId: receiverId,
                    //       isGroupChat: isGroupChat,
                    //     ));
                  },
                ),
                AttachmentCardItem(
                  name: "المعرض",
                  color: Colors.purpleAccent,
                  icon: Icons.photo,
                  onPress: () {
                    selectImageFromGallery(context);
                  },
                ),
                AttachmentCardItem(
                  name: "موسيقى",
                  color: Colors.orange,
                  icon: Icons.headphones,
                  onPress: () {
                    pickFileAudio(context);
                  },
                ),
                AttachmentCardItem(
                    name: "الأسماء",
                    color: Colors.blue,
                    icon: Icons.person,
                    onPress: () {
                      // FlutterContacts.openExternalPick();
                      Navigator.pop(context); // Close the popup menu
                    })
              ],
            ),
          )
        ];
      },
    );
  }

  void pickFileDocument(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'rar', 'pptx', 'csv', 'txt'],
    );

    if (result != null && result.files.single.path != null) {
      PlatformFile file = result.files.first;
      if (file != null) {
        Navigator.pushNamed(context, DocumentPreviewPage.routeName,
            arguments: DocumentPreviewPage(
              DocumentFilePath: file,
              receiverId: "File",
              singleChatEntity: singleChatEntity,
            ));
      }
    } else {}
  }

  void pickFileAudio(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.audio,
    );

    if (result != null && result.files.single.path != null) {
      PlatformFile file = result.files.first;
      if (file != null) {
        Navigator.pushNamed(context, DocumentPreviewPage.routeName,
            arguments: DocumentPreviewPage(
              DocumentFilePath: file,
              receiverId: "Audio",
              singleChatEntity: singleChatEntity,
            ));
      }
    } else {}
  }

  void _pickMultipleFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      // setState(() {
      //   _fileText = files.toString();
      // });
    } else {
      // User canceled the picker
    }
  }

  void _pickDirectory() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      // setState(() {
      //   _fileText = selectedDirectory;
      // });
    } else {
      // User canceled the picker
    }
  }

  // This  function that selects an image from the device's gallery,
  void selectImageFromGallery(BuildContext context) async {
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      Navigator.pushNamed(context, ImagePreviewPage.routeName,
          arguments: ImagePreviewPage(
            imageFilePath: image,
            singleChatEntity: singleChatEntity,
          ));
    }
  }
}

class AttachmentCardItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final VoidCallback onPress;

  const AttachmentCardItem(
      {super.key,
      required this.name,
      required this.icon,
      required this.color,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color,
            child: IconButton(
              icon: Icon(icon),
              splashRadius: 28,
              onPressed: onPress,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
