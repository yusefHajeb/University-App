// ignore_for_file: depend_on_referenced_packages
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../core/color/app_color.dart';
import '../../../../../core/value/global.dart';
import '../../../data/models/library_models/library_model.dart';
import '../../bloc/book_favorite_bloc/books_favorite_bloc.dart';
import '../../widget/library_widget.dart/reading_book.dart';

class TestDownload extends StatefulWidget {
  // final String url;
  final LibraryModel bookDownload;
  // final String fileName;
  const TestDownload({
    required this.bookDownload,

    // required this.fileName,
    super.key,
  });

  @override
  State<TestDownload> createState() => _TestDownloadState();
}

class _TestDownloadState extends State<TestDownload> {
  bool isDowLoading = false;
  bool fileExists = false;
  double progress = 0.0;
  Directory? pathes;
  bool? confige;
  String fileName = "";
  late String filePath;
  File? saveFile;
  late CancelToken cancelToken;
  String linkStor = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      fileName = path.basename(widget.bookDownload.pdfUrl ?? "");
    });
  }

  startDownload() async {
    cancelToken = CancelToken();
    pathes = await getDownloadsDirectory();
    PermissionStatus status = await Permission.storage.request();
    status = await Permission.storage.status;
    if (!status.isDenied) {
      print(status.isDenied);
      // await Permission.storage.request();
      String storePath = '';

      List<String> folders = pathes!.path.split('/');
      for (int x = 1; x < folders.length; x++) {
        String folder = folders[x];
        if (folder != "Android") {
          storePath += "/" + folder;
        } else {
          break;
        }
      }
      print("storage Path");
      print(storePath);

      storePath = storePath + "/University";
      if ((await pathes!.exists())) {
        print("Create File Successfuly");

        await pathes!.create(recursive: true);
      }
      pathes = Directory(storePath);
      filePath = "$storePath/$fileName";
      saveFile = File(filePath);
      linkStor = filePath;
      // File saveFile = File('${pathes?.path}/$fileName');

      setState(() {
        isDowLoading = true;
        progress = 0;
      });
      try {
        await Dio().download(
          widget.bookDownload.pdfUrl ?? "",
          filePath,
          onReceiveProgress: (count, total) => setState(() {
            progress = (count / total);
          }),
          cancelToken: cancelToken,
        );
        setState(() async {
          isDowLoading = false;
          fileExists = true;
          print("----------------------------");
          BlocProvider.of<BooksFavoriteBloc>(context)
              .add(StartDownloadEvent(book: widget.bookDownload));
          print("book Library Download");
          print(widget.bookDownload.toJson());
          await Global.storgeServece
              .setBool(widget.bookDownload.pdfUrl ?? "", true);
        });
      } catch (e) {
        setState(() {
          isDowLoading = false;
        });
        if (kDebugMode) {
          print(e);
        }
      }
    } else {
      print("Not Permission");
    }
  }

  cancelDownload() async {
    cancelToken.cancel();
    setState(() {
      isDowLoading = false;
    });
  }

  checkFileExist() async {
    String storePath = await pathes!.path;
    filePath = "$storePath/$fileName";
    bool isFileExist = await File(filePath).exists();
    setState(() {
      fileExists = isFileExist;
      print("checkFileExist()");
      print(fileExists);
    });
  }

  openFile() async {
    print("filePath===");
    print(saveFile?.path);

    confige =
        await Global.storgeServece.getBool(widget.bookDownload.pdfUrl ?? "");
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ReadingBook(
            pdfPath: filePath,
            file: saveFile!,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return isDowLoading
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text("P D F"),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 3,
                      backgroundColor: Colors.grey,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),
                  Center(
                    child: Text(
                      "${(progress * 100).toStringAsFixed(2)}%",
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (!fileExists && isDowLoading) {
                    cancelDownload();
                  } else {
                    if (kDebugMode) {
                      print("delete");
                    }
                  }
                },
                child: const Text("Cancel"),
              ),
            ],
          )
        : TextButton(
            onPressed: () {
              (fileExists && !isDowLoading) ? openFile() : startDownload();
            },
            child: Container(
                decoration: BoxDecoration(
                  color: confige != null
                      ? Colors.green
                      : AppColors.backgroundPages,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                width: 35,
                height: 33,
                alignment: Alignment.center,
                child: Icon(
                  Icons.downloading_outlined,
                  size: 22,
                  color: AppColors.white,
                )

                // IconButton(
                ),

            //  Text(
            //   (fileExists && !isDowLoading) ? "Open" : "Download",
            //   style: TextStyle(
            //     color:
            //         (fileExists && !isDowLoading) ? Colors.green : Colors.blue,
            //   ),
            // ),
          );
  }
}
