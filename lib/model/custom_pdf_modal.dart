import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";
import "package:file_picker/file_picker.dart";

class customPdf {
  static Future<File> _storeFile(String url, List<int> bytes) async {
    // its basically gives the file name
    final fileName = basename(url);
    // app directory in local phone storage so that we can store data
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/$fileName");
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  static Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) {
      return null;
    }
    return File(result.paths.first as String);
  }

  static Future<File?> loadFireBase(String fileName) async {
    try {
      final result = FirebaseStorage.instance.ref().child(fileName);
      final bytes = await result.getData();
      return _storeFile(fileName, bytes as Uint8List);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
