import "package:path/path.dart";
import "package:path_provider/path_provider.dart";
import "package:http/http.dart";
import "package:file_picker/file_picker.dart";
import "package:flutter/material.dart";
import "package:pdf_merger/pdf_merger.dart";

import "dart:io";

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
      allowedExtensions: ["pdf"],
    );
    if (result == null) {
      return null;
    }
    print("files selected");
    print(result.files.length);
    if (result.files.length == 1) {
      print("single file is seleted");
      print(result.files[0].path);
      return File(result.files[0].path as String);
    } else {
      print("multiple files are seleted");
      String tempCachePath = "/data/user/0/com.example.xerox/cache/multiple_pdfs.pdf";
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
