import "package:path/path.dart";
import "package:path_provider/path_provider.dart";
import "package:http/http.dart";
import "package:file_picker/file_picker.dart";
import "package:flutter/material.dart";

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
      type: FileType.custom,
      allowedExtensions: ["pdf"],
    );
    if (result == null) {
      return null;
    }
    return File(result.paths.first as String);
  }
}
