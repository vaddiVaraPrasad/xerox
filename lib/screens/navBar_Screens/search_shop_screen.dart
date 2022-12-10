import "package:flutter/material.dart";
import 'package:xerox/screens/pdf/pdf_filters_Screen.dart';

class SearchShop extends StatelessWidget {
  static const routeName = "/searchScreen";
  const SearchShop({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(PdfFilters.routeName);
            },
            child: const Text("press to go filteres screen")));
  }
}
