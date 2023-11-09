// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:university/core/Utils/box_decoration.dart';
import 'package:university/core/constant/varibal.dart';
import '../../../../../app/enjection_container.dart' as di;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/color/app_color.dart';
import '../../../data/models/library_models/library_model.dart';
import '../../bloc/book_favorite_bloc/books_favorite_bloc.dart';
import '../../widget/library_widget.dart/reading_book.dart';
import '../../widget/profile_widget/text_autline.dart';

class TestDownload extends StatefulWidget {
  final BookModel bookDownload;
  const TestDownload({
    required this.bookDownload,
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
  bool? confige = false;
  late final SharedPreferences sharedPreferences;
  String fileName = "";
  late String filePath;
  File? saveFile;
  late CancelToken cancelToken;
  String linkStor = "";
  List<BookModel> localBook = [];
  Future<void> getInstate() async {
    await di.init();
  }

  @override
  void dispose() {
    confige = false;
    fileName = "";
    super.dispose();
  }

  @override
  void initState() {
    sharedPreferences = di.sl<SharedPreferences>();
    super.initState();
    setState(() {
      confige = false;
    });
  }

  startDownload() async {
    cancelToken = CancelToken();
    localBook = [];
    pathes = await getDownloadsDirectory();
    PermissionStatus status = await Permission.storage.request();
    status = await Permission.storage.status;
    if (!status.isDenied) {
      String storePath = '';

      List<String> folders = pathes!.path.split('/');
      for (int x = 1; x < folders.length; x++) {
        String folder = folders[x];
        if (folder != "Android") {
          storePath += "/" + folder;
        } else {
          folder = "University";
          break;
        }
      }
      if ((await pathes!.exists())) {
        await pathes!.create(recursive: true);
      }
      pathes = Directory(storePath);
      fileName = path.basename(widget.bookDownload.pdfUrl ?? "");

      filePath = "$storePath/$fileName";
      saveFile = File(filePath);
      print("saveFile!.path");
      print(saveFile!.path);
      linkStor = filePath;
      setState(() {
        isDowLoading = true;
        progress = 0;
      });
      try {
        await Dio().download(
          Constants.pdfRoute + widget.bookDownload.pdfUrl.toString(),
          filePath,
          onReceiveProgress: (count, total) => setState(() {
            progress = (count / total);
          }),
          cancelToken: cancelToken,
        );

        final decodeJsonData =
            sharedPreferences.getString(Constants.savedBooks);
        if (decodeJsonData != null) {
          List decodeBooks = json.decode(decodeJsonData);
          localBook = decodeBooks
              .map<BookModel>((jsonData) => BookModel.formJson(jsonData))
              .toList();
          localBook.add(widget.bookDownload.copyWith(
              pdfUrl: saveFile!.path,
              courseId: widget.bookDownload.courseId,
              tId: widget.bookDownload.tId,
              bookImage: widget.bookDownload.imgBook,
              bookName: widget.bookDownload.bookName));
          confige = await sharedPreferences.setString(
              Constants.savedBooks, json.encode(localBook));
        } else {
          print("not Found any Books");

          BookModel model = widget.bookDownload;
          localBook.add(widget.bookDownload.copyWith(
              pdfUrl: saveFile!.path,
              courseId: model.courseId,
              bookImage: model.imgBook,
              bookName: model.bookName,
              tId: model.tId,
              bookAuther: model.bookAuthor));
          confige = await sharedPreferences.setString(
            Constants.savedBooks,
            json.encode(localBook),
          );
        }
        setState(() {
          isDowLoading = false;
          fileExists = true;
          BlocProvider.of<DownloadBooksBloc>(context).add(StartDownloadEvent());
        });
      } catch (e, s) {
        setState(() {
          isDowLoading = false;
        });
        if (kDebugMode) {
          print(e);
          print(s);
        }
      }
    } else {}
  }

  cancelDownload() async {
    cancelToken.cancel();
    setState(() {
      isDowLoading = false;
    });
  }

  openFile() async {
    localBook = [];
    print("widget.bookDownload ==== ");
    print(widget.bookDownload);
    final decodeJsonData = sharedPreferences.getString(Constants.savedBooks);
    if (decodeJsonData != null) {
      List decodeBooks = json.decode(decodeJsonData);
      localBook = decodeBooks
          .map<BookModel>((jsonData) => BookModel.formJson(jsonData))
          .toList();
    }

    // if (localBook.isNotEmpty) {
    for (var element in localBook) {
      if (widget.bookDownload.tId == element.tId) {
        bool isFileExist = await File("${element.pdfUrl}").exists();
        if (isFileExist) {
          File filePath = File("${element.pdfUrl}");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ReadingBook(
                file: filePath,
                fileName: element.bookName,
              ),
            ),
          );
          print(filePath);
          print("file Name");
          break;
        }

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => ReadingBook(
        //       file: filePath,
        //       fileName: element.bookName,
        //     ),
        //   ),
        // );
        // }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final decodeJsonData = sharedPreferences.getString(Constants.savedBooks);
    List<BookModel> lib = [];
    if (decodeJsonData != null) {
      List decodeBooks = json.decode(decodeJsonData);
      lib = decodeBooks
          .map<BookModel>((jsonData) => BookModel.formJson(jsonData))
          .toList();
    }
    if (lib.isNotEmpty) {
      lib.forEach(
        (element) {
          if (widget.bookDownload.tId == element.tId) {
            confige = true;
          }
        },
      );
    }

    return isDowLoading
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.bottomHeaderColor),
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
                  Container(
                    child: Text(
                      "${(progress * 100).toStringAsFixed(2)}%",
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              OutlinedButtonWithText(
                onPressed: () {
                  if (!fileExists && isDowLoading) {
                    cancelDownload();
                  } else {
                    if (kDebugMode) {
                      print("delete");
                    }
                  }
                },
                content: "الغاء",
                width: 60,
              )
            ],
          )
        : Container(
            width: 50,
            height: 50,
            // decoration: BoxDecorationStyles.fadingGlory,
            child: TextButton(
              onPressed: () {
                confige == true ? openFile() : startDownload();

                // (await File("${widget.bookDownload.pdfUrl}").exists() == true
                //     ? openFile()
                //     : startDownload());
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: confige == true
                        ? Colors.green
                        : AppColors.backgroundPages,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  child: Icon(
                    confige == true
                        ? Icons.download_done
                        : Icons.downloading_outlined,
                    size: 22,
                    color: AppColors.white,
                  )),
            ));
  }
}
