import "package:flutter/material.dart";
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:line_icons/line_icons.dart';

import "../pdf/custom_pdf_Render_Screen.dart";
import "../../model/custom_pdf_modal.dart";

class RateUsScreen extends StatelessWidget {
  const RateUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
            icon: Icon(LineIcons.bars),
          ),
          ElevatedButton(
            onPressed: () async {
              final file = await customPdf.pickFile();
              if (file == null) return;
              Navigator.of(context)
                  .pushNamed(CustomPDFViewer.routeName, arguments: file);
            },
            child: const Text("pick pdf and render"),
          ),
          ElevatedButton(
              onPressed: () {}, child: Text("pick file from firebase"))
        ],
      ),
    );
  }
}
