import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import "package:syncfusion_flutter_pdfviewer/pdfviewer.dart";

import "dart:io";

import 'package:xerox/utils/color_pallets.dart';

import '../../widgets/auth/sing_in_up_bar.dart';

class CustomPDFPreview extends StatefulWidget {
  static const routeName = "/cutomPDFPreview";
  const CustomPDFPreview({super.key});

  @override
  State<CustomPDFPreview> createState() => _CustomPDFPreviewState();
}

class _CustomPDFPreviewState extends State<CustomPDFPreview> {
  bool isUploadingToFirebase = false;

  void uploadToFirebase(
      File uploadFile, String fileName, BuildContext ctx) async {
    setState(() {
      isUploadingToFirebase = true;
    });
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      final refPath = FirebaseStorage.instance
          .ref()
          .child("user")
          .child(userId)
          .child("pdfiles")
          .child(fileName);

      await refPath.putFile(uploadFile).whenComplete(() {});
      String uploadedPdfUrl = await refPath.getDownloadURL();
      print("PDf is  uploaded succesfully ");
      print(uploadedPdfUrl);
      Navigator.of(ctx).pop();
    } catch (e) {
      showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            title: const Text("Something went wrong !!"),
            content: Text(e.toString()),
            actions: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  FontAwesomeIcons.check,
                  size: 30,
                ),
              )
            ],
          );
        },
      );
    } finally {
      setState(() {
        isUploadingToFirebase = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    File file = ModalRoute.of(context)!.settings.arguments as File;
    String fileName = basename(file.path);
    String displayName = basename(file.path).split('.')[0];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          displayName,
          style: const TextStyle(
            color: ColorPallets.white,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: SfPdfViewer.file(
        file,
        canShowScrollHead: true,
        canShowScrollStatus: true,
        pageLayoutMode: PdfPageLayoutMode.continuous,
        scrollDirection: PdfScrollDirection.vertical,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: ColorPallets.lightPurplishWhile.withOpacity(.4),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(26),
              topLeft: Radius.circular(26),
            ),
            boxShadow: const [
              BoxShadow(
                  color: ColorPallets.lightPurplishWhile,
                  offset: Offset(0, 0),
                  blurRadius: 40,
                  blurStyle: BlurStyle.outer)
            ]),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        child: SignInBar(
            label: "procede",
            isLoading: isUploadingToFirebase,
            onPressed: () => uploadToFirebase(file, fileName, context)),
      ),
    );
  }
}
