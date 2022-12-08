import "package:path/path.dart";
import "package:path_provider/path_provider.dart";
import "package:http/http.dart";
import "package:file_picker/file_picker.dart";
import "package:flutter/material.dart";
import "package:pdf_merger/pdf_merger.dart";

import "dart:io";

import 'package:syncfusion_flutter_pdf/pdf.dart';

class CustomPDF {
  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/$filename");
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  static Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      // allowedExtensions: ["pdf", "doc", "docx"],
      allowedExtensions: ["pdf"]
    );
    if (result == null) {
      return null;
    }
    if (result.files.length == 1) {
      String filepath = result.files[0].path as String;
      if (filepath.endsWith('.doc') || filepath.endsWith('.docx')) {
        // String docName = basename(filepath).split('.')[0];
        // print("base name is $docName");
        // final dir = await getApplicationDocumentsDirectory();
        // final pdfFilePath = "${dir.path}/$docName.pdf";
        // final file = File(pdfFilePath);
        // final bytes = await File(filepath).readAsBytes();
        // await file.writeAsBytes(bytes, flush: true);
        // print(filepath);
        // print("file is generated");
        // print(file.path);
        // final PdfDocument newpdf = PdfDocument(inputBytes: bytes);
        // print(newpdf);
        // File tempfile = File(fileDocPdfpath);
        // await tempfile.writeAsBytes(bytes, flush: true);
        // return file;
      }
      return File(result.files[0].path as String);
    } else {
      String tempCachePath =
          "/data/user/0/com.example.xerox/cache/multiple_pdfs.pdf";
      List<String> filesPathList = [];
      for (int i = 0; i < result.files.length; i++) {
        filesPathList.add(result.files[i].path as String);
      }
      MergeMultiplePDFResponse resultMerge = await PdfMerger.mergeMultiplePDF(
          paths: filesPathList, outputDirPath: tempCachePath);

      if (resultMerge.status == "success") {
        // resultMerge.response gives u the path of hte merged file
        print(resultMerge.response);
        return File(resultMerge.response as String);
      }
    }
    return null;
  }
}
