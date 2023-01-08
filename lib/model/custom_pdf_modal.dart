import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";
// import "package:http/http.dart";
import "package:file_picker/file_picker.dart";
// import "package:flutter/material.dart";
import "package:pdf_merger/pdf_merger.dart";
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import "dart:io";

class CustomPDF {
  // static Future<File> _storeFile(String url, List<int> bytes) async {
  //   final filename = basename(url);
  //   final dir = await getApplicationDocumentsDirectory();
  //   final file = File("${dir.path}/$filename");
  //   await file.writeAsBytes(bytes, flush: true);
  //   return file;
  // }

  Future<File?> pickProfilePic() async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile == null) {
      return null;
    }
    return File(pickedFile.path);
  }

  static Future<File?> pickFile() async {
    final result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.custom,
            // allowedExtensions: ["pdf", "doc", "docx"],
            allowedExtensions: ["pdf"]);
    if (result == null) {
      return null;
    }
    if (result.files.length == 1) {
      String filepath = result.files[0].path as String;
      if (filepath.endsWith('.doc') || filepath.endsWith('.docx')) {
        // String docName = basename(filepath).split('.')[0];
        // print("base name is $docName");
        // final dir = await getTemporaryDirectory();
        // final pdfFilePath = "${dir.path}/$docName.pdf";
        // // getting the context of pdf in uint8list formate  !!!
        // final bytes = await File(filepath).readAsBytes();
        // print(bytes.length);
        // print(pdfFilePath);
        // print(filepath);

        // final pdf = pw.Document();
        // final _pageTheme = pw.PageTheme(pageFormat: PdfPageFormat.a4);
        // pdf.addPage(
        //   pw.MultiPage(
        //     pageTheme: _pageTheme,
        //     build: (context) => [
        //       pw.Image(pw.MemoryImage(bytes),
        //           width: _pageTheme.pageFormat.width,
        //           height: _pageTheme.pageFormat.height,
        //           fit: pw.BoxFit.contain)
        //     ],
        //   ),
        // );
        // final file = File(pdfFilePath);
        // await file.writeAsBytes(await pdf.save());
        // return file;
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

  static Future<File> getPdfImage(String path) async {
    final pdf = pw.Document();
    // final pngImage1 = (await rootBundle.load(path)).buffer.asUint8List();

    final bytes = await File(path).readAsBytes();

    // const pageTheme = pw.PageTheme(pageFormat: PdfPageFormat.a4);

    // pdf.addPage(
    //   pw.MultiPage(
    //     pageTheme: pageTheme,
    //     build: (context) => [
    //       pw.Image(pw.MemoryImage(bytes),
    //           // width: pageTheme.pageFormat.availableWidth,
    //           // height: pageTheme.pageFormat.availableHeight,
    //           fit: pw.BoxFit.cover),
    //     ],
    //   ),
    // );
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Expanded(
              child: pw.Image(
            pw.MemoryImage(bytes),
            fit: pw.BoxFit.cover,
          ));
        }));
    final basenamefile = basename(path);
    String basefilename = basenamefile.split(".")[0];
//   final output = await getTemporaryDirectory();
    final dir = await getTemporaryDirectory();
    final file = File("${dir.path}/$basefilename.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  Future<File?> generateImagesPdfFromMultiImages(
      String fileName, List<File> listImagesFile) async {
    List<File> listPdfFile = [];
    List<String> listPdfPaths = [];
    for (int i = 0; i < listImagesFile.length; i++) {
      final tempfile = await getPdfImage(listImagesFile[i].path);
      listPdfFile.add(tempfile);
    }
    for (int i = 0; i < listPdfFile.length; i++) {
      listPdfPaths.add(listPdfFile[i].path);
    }
    final dir = await getTemporaryDirectory();
    String combileFileName = "${dir.path}/$fileName.pdf";
    MergeMultiplePDFResponse resultMerge = await PdfMerger.mergeMultiplePDF(
        paths: listPdfPaths, outputDirPath: combileFileName);
    if (resultMerge.status == "success") {
      return File(resultMerge.response as String);
    }

    return null;
  }

  // Future<File?> generateImagesPdfFromMultiImages(
  //     String fileName, List<File> listImagesFiles) async {}
  // Future<File?> generateSingleImage(String fileName, File imageFile) async {
  //   final pdfimage = PdfImage.file(imageFile, bytes: bytes);
  // }
}
