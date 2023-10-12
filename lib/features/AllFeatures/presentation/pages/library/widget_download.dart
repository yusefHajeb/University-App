// // ignore_for_file: depend_on_referenced_packages
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:open_filex/open_filex.dart';
// import 'package:path/path.dart' as path;


// class TestDownload extends StatefulWidget {
//   final String url;
//   const TestDownload({
//     required this.url,
//     super.key,
//   });

//   @override
//   State<TestDownload> createState() => _TestDownloadState();
// }

// class _TestDownloadState extends State<TestDownload> {
//   bool isDowLoading = false;
//   bool fileExists = false;
//   double progress = 0.0;

//   DirectoryPath pathes = DirectoryPath();
//   String fileName = "";
//   late String filePath;
//   late CancelToken cancelToken;

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       fileName = path.basename(widget.url);
//     });
//   }

//   startDownload() async {
//     cancelToken = CancelToken();
//     String storePath = await pathes.getPath();
//     filePath = "$storePath/$fileName";
//     setState(() {
//       isDowLoading = true;
//       progress = 0;
//     });
//     try {
//       await Dio().download(
//         widget.url,
//         filePath,
//         onReceiveProgress: (count, total) => setState(() {
//           progress = (count / total);
//         }),
//         cancelToken: cancelToken,
//       );
//       setState(() {
//         isDowLoading = false;
//         fileExists = true;
//       });
//     } catch (e) {
//       setState(() {
//         isDowLoading = false;
//       });
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//   }

//   cancelDownload() async {
//     cancelToken.cancel();
//     setState(() {
//       isDowLoading = false;
//     });
//   }

//   checkFileExist() async {
//     String storePath = await pathes.getPath();
//     filePath = "$storePath/$fileName";
//     bool isFileExist = await File(filePath).exists();
//     setState(() {
//       fileExists = isFileExist;
//     });
//   }

//   openFile() {
//     OpenFilex.open(filePath);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isDowLoading
//         ? Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {},
//                 child: const Text("P D F"),
//               ),
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   SizedBox(
//                     height: 50,
//                     width: 50,
//                     child: CircularProgressIndicator(
//                       value: progress,
//                       strokeWidth: 3,
//                       backgroundColor: Colors.grey,
//                       valueColor:
//                           const AlwaysStoppedAnimation<Color>(Colors.green),
//                     ),
//                   ),
//                   Center(
//                     child: Text(
//                       "${(progress * 100).toStringAsFixed(2)}%",
//                       style: const TextStyle(fontSize: 12),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (!fileExists && isDowLoading) {
//                     cancelDownload();
//                   } else {
//                     if (kDebugMode) {
//                       print("delete");
//                     }
//                   }
//                 },
//                 child: const Text("Cancel"),
//               ),
//             ],
//           )
//         : TextButton(
//             onPressed: () {
//               (fileExists && !isDowLoading) ? openFile() : startDownload();
//             },
//             child: Text(
//               (fileExists && !isDowLoading) ? "Open" : "Download",
//               style: TextStyle(
//                 color:
//                     (fileExists && !isDowLoading) ? Colors.green : Colors.blue,
//               ),
//             ),
//           );
//   }
// }
