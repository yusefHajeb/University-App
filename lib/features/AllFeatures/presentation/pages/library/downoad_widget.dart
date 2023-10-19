// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:university/core/constant/varibal.dart';
import 'package:university/features/AllFeatures/presentation/bloc/book_favorite_bloc/books_favorite_bloc.dart';
import '../../../../../app/enjection_container.dart' as di;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/color/app_color.dart';
import '../../../data/models/library_models/library_model.dart';
import '../../widget/library_widget.dart/reading_book.dart';

class TestDownload extends StatefulWidget {
  final LibraryModel bookDownload;
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
  List<LibraryModel> localBook = [];
  Future<void> getInstate() async {
    await di.init();
  }

  void initState() {
    sharedPreferences = di.sl<SharedPreferences>();
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
      if ((await pathes!.exists())) {
        await pathes!.create(recursive: true);
      }
      pathes = Directory(storePath);
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
          widget.bookDownload.pdfUrl ?? "",
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
              .map<LibraryModel>((jsonData) => LibraryModel.formJson(jsonData))
              .toList();
          localBook.add(widget.bookDownload.copyWith(
              pdfUrl: saveFile!.path,
              img_book: widget.bookDownload.img_book,
              name_book: widget.bookDownload.name_book));
          confige = await sharedPreferences.setString(
              Constants.savedBooks, json.encode(localBook));
        } else {
          List<LibraryModel> lib = [];
          LibraryModel model = widget.bookDownload;
          lib.add(widget.bookDownload.copyWith(
              pdfUrl: saveFile!.path,
              id: model.id,
              category_id: model.category_id,
              img_book: model.img_book,
              name_book: model.name_book,
              subject: model.subject,
              write_book: model.write_book));
          confige = await sharedPreferences.setString(
            Constants.savedBooks,
            json.encode(lib),
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

  checkFileExist() async {
    String storePath = await pathes!.path;
    filePath = "$storePath/$fileName";
    bool isFileExist = await File(filePath).exists();
    setState(() {
      fileExists = isFileExist;
    });
  }

  openFile() async {
    final decodeJsonData = sharedPreferences.getString(Constants.savedBooks);
    if (decodeJsonData != null) {
      List decodeBooks = json.decode(decodeJsonData);
      localBook = decodeBooks
          .map<LibraryModel>((jsonData) => LibraryModel.formJson(jsonData))
          .toList();
    }
    if (localBook.isNotEmpty) {
      for (var element in localBook) {
        if (widget.bookDownload.id == element.id) {
          File filePath = File("${element.pdfUrl}");

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ReadingBook(
                file: filePath,
              ),
            ),
          );
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final decodeJsonData = sharedPreferences.getString(Constants.savedBooks);
    if (decodeJsonData != null) {
      List decodeBooks = json.decode(decodeJsonData);
      localBook = decodeBooks
          .map<LibraryModel>((jsonData) => LibraryModel.formJson(jsonData))
          .toList();
    }
    if (localBook.isNotEmpty) {
      localBook.forEach(
        (element) {
          if (widget.bookDownload.id == element.id) {
            confige = true;
          }
        },
      );
    }

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
        : Container(
            width: 50,
            height: 50,
            child: TextButton(
              onPressed: () {
                confige == true ? openFile() : startDownload();
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
