import 'dart:io';
import 'package:xerox/screens/pdf/cutom_pdf_Render_Screen.dart';

import "../../model/custom_pdf_modal.dart";

import "package:flutter/material.dart";

import 'package:edge_detection/edge_detection.dart';

class PdfImagesRender extends StatefulWidget {
  static const routeName = "/pdfImagesrender";
  const PdfImagesRender({super.key});

  @override
  State<PdfImagesRender> createState() => _PdfImagesRenderState();
}

class _PdfImagesRenderState extends State<PdfImagesRender> {
  String? fileName;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  List<File> listfiles = [];

  void addFileToList() async {
    File? file = await CustomPDF().pickProfilePic();
    if (file == null) {
      return;
    }
    setState(() {
      listfiles.add(file);
    });
  }

  void addFileToLisFromEdgeDet() async {
    final tempimagePath = (await EdgeDetection.detectEdge);
    if (tempimagePath == null) {
      return;
    }
    print("temp image path is $tempimagePath");
    File tempfile = File(tempimagePath);
    if (tempfile == null) {
      return;
    }
    setState(() {
      listfiles.add(tempfile);
    });
  }

  Future<File?> onSaveNameSendFilePreviw() async {
    final isvalid = formKey.currentState!.validate();
    if (isvalid) {
      formKey.currentState!.save();
    }
    Navigator.of(context).pop();
    print("file name is $fileName");

    // send the list of images to modal and get pdf from it !!!
    print("all these has to done");
    setState(() {
      isLoading = true;
    });
    print("before calling generate pdfs");
    File? resultFile = await CustomPDF()
        .generateImagesPdfFromMultiImages(fileName as String, listfiles);
    print("pdf is generated succefully");
    
    return resultFile;
    // setState(() {
    //   isLoading = false;
    // });
    // Navigator.of(ctx)
    //     .pushNamed(CustomPDFPreview.routeName, arguments: resultFile);
    // and then preview it by previews screen
  }

  void showGetFileName(BuildContext ctx) async {
    //get the name
    showDialog(
      context: ctx,
      builder: (context) => AlertDialog(
        title: const Text(
          "Enter the FileName ",
          textAlign: TextAlign.center,
        ),
        titlePadding: const EdgeInsets.only(
          top: 20,
        ),
        contentPadding: const EdgeInsets.only(bottom: 0, left: 10, right: 10),
        content: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextFormField(
              decoration: const InputDecoration(hintText: "FileName"),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              validator: (filename) {
                if (filename!.isEmpty) {
                  return "invalid file name";
                }
                return null;
              },
              onSaved: (filename) {
                if (filename != null) {
                  fileName = filename;
                }
              },
              onFieldSubmitted: (value) async {
                final file = await onSaveNameSendFilePreviw();
                if (file == null) {
                  return;
                }
                openPreview(ctx, file);
              },
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                final file = await onSaveNameSendFilePreviw();
                if (file == null) {
                  return;
                }
                openPreview(ctx, file);
              },
              child: const Text("Get Preview !"))
        ],
      ),
    );
  }

  void openPreview(BuildContext ctx, File resultFile) {
    setState(() {
      isLoading = false;
    });
    Navigator.of(ctx)
        .pushNamed(CustomPDFPreview.routeName, arguments: resultFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("preview images"),
        actions: [
          listfiles.isNotEmpty
              ? IconButton(
                  onPressed: () => showGetFileName(context),
                  icon: const Icon(Icons.save),
                )
              : const SizedBox(),
          IconButton(
            onPressed: addFileToLisFromEdgeDet,
            icon: const Icon(Icons.add_a_photo),
          ),
          IconButton(
            onPressed: addFileToList,
            icon: const Icon(Icons.add_a_photo),
          )

        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : listfiles.isEmpty
              ? const Center(
                  child: Text(
                  "Add files by clicking on top right button!!",
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ))
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: listfiles.length,
                    itemBuilder: (context, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: GridTile(
                        footer: SizedBox(
                          height: 40,
                          child: GridTileBar(
                              backgroundColor: Colors.black54,
                              title: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    listfiles.removeAt(index);
                                  });
                                },
                              )),
                        ),
                        child: Image.file(
                          listfiles[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }
}
