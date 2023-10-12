import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../core/color/app_color.dart';
import '../../../../../core/widget/buttons/default_back.dart';

class ReadingBook extends StatefulWidget {
  final String pdfPath;
  final File file;
  ReadingBook({required this.pdfPath, required this.file});

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
        backgroundColor: AppColors.backgrounfContent,
        title: DefaultNav(title: "\t\t\t "),
        leading: isFullScreen
            ? IconButton(
                icon: const Icon(Icons.close_fullscreen_outlined),
                onPressed: () {
                  print("widget.pdfPath");
                  print(widget.pdfPath);
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
