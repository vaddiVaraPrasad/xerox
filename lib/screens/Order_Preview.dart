import 'dart:io';

import 'package:flutter/material.dart';

class OrderPreviewScreen extends StatelessWidget {
  static const routeName = "/orderFilePreview";
  const OrderPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    File file = navData["pdfFile"];
    String fileName = navData["fileName"];

    return const Placeholder();
  }
}
