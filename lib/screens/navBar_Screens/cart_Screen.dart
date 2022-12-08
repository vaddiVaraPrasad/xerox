import "package:flutter/material.dart";
import "dart:io";

import '../../model/custom_pdf_modal.dart';
import '../pdf/cutom_pdf_Render_Screen.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "/cartScreen";
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isPdfLoading = false;
  @override
  Widget build(BuildContext context) {
    return isPdfLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: ElevatedButton(
                  child: const Text("file pdf"),
                  onPressed: () async {
                    setState(() {
                      isPdfLoading = true;
                    });
                    File? file = await CustomPDF.pickFile();
                    if (file == null) {
                      setState(() {
                        isPdfLoading = false;
                        return;
                      });
                    }
                    openFile(context, file as File);
                  },
                ),
              )
            ],
          );
  }

  void openFile(BuildContext ctx, File file) {
    setState(() {
      isPdfLoading = false;
    });
    Navigator.of(ctx).pushNamed(CustomPDFPreview.routeName, arguments: file);
    // setState(() {
    //   isPdfLoading = false;
    // });
  }
}
