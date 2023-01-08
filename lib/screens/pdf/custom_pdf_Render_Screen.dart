import "package:flutter_pdfview/flutter_pdfview.dart";
import "package:flutter/material.dart";
import "dart:io";

import 'package:path/path.dart';

class CustomPDFViewer extends StatefulWidget {
  static const routeName = "/customPdfRenderScreen";

  const CustomPDFViewer();

  @override
  State<CustomPDFViewer> createState() => _CustomPDFViewerState();
}

class _CustomPDFViewerState extends State<CustomPDFViewer> {
  @override
  Widget build(BuildContext context) {
    File file = ModalRoute.of(context)!.settings.arguments as File;

    final name = basename(file.path);
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: PDFView(
        filePath: file.path,
      ),
    );
  }
}
