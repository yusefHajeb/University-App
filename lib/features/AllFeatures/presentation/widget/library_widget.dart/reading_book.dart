import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:university/core/value/app_space.dart';

import '../../../../../core/color/app_color.dart';
import '../../../../../core/widget/buttons/button_back.dart';
import '../../../../../core/widget/buttons/default_back.dart';
import '../../../../../core/widget/dummy/profile_dummy.dart';

class ReadingBook extends StatefulWidget {
  final File file;
  String? fileName;
  ReadingBook({required this.file, this.fileName = ""});

  @override
  _ReadingBookState createState() => _ReadingBookState();
}

class _ReadingBookState extends State<ReadingBook> {
  int totalPages = 0;
  int currentPage = 0;
  bool isFullScreen = false;
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgrounfContent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppBackButton(),
            Text("${widget.fileName?.toString()}"),
            AppSpaces.horizontalSpace10,
          ],
        ),
        leading: isFullScreen
            ? IconButton(
                icon: const Icon(Icons.close_fullscreen_outlined),
                onPressed: () {
                  print("${widget.file.path}");

                  setState(() {
                    isFullScreen = false;
                  });
                },
              )
            : null,
        actions: [
          if (!isFullScreen)
            IconButton(
              icon: const Icon(Icons.fullscreen_outlined),
              onPressed: () {
                setState(() {
                  isFullScreen = true;
                });
              },
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SfPdfViewer.file(
              widget.file,
              controller: _pdfViewerController,
              onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                setState(() {
                  totalPages = details.document.pages.count;
                });
              },
              onPageChanged: (PdfPageChangedDetails details) {
                setState(() {
                  currentPage = details.oldPageNumber;
                });
              },
            ),
          ),
          Visibility(
            visible: !isFullScreen,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.navigate_before),
                  onPressed: () {
                    _pdfViewerController.previousPage();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Page $currentPage of $totalPages',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.navigate_next),
                  onPressed: () {
                    _pdfViewerController.nextPage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
