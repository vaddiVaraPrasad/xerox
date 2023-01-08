import 'dart:io';

import 'package:flutter/material.dart';

import '../model/ListShopes.dart';
import 'pdf/pdf_filters_Screen.dart';

class DummyShops extends StatelessWidget {
  static const routeName = "/dummyShopes";

  const DummyShops({
    super.key,
  });

  // when ever when user select anyshop it has to that that shop id and file to filters page
  // with shop id its fetches the price of the differnt types of xerox

  @override
  Widget build(BuildContext context) {
    File file = ModalRoute.of(context)!.settings.arguments as File;
    return Scaffold(
      appBar: AppBar(
        title: const Text("shopes"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView(children: [
          InkWell(
            onTap: () {
              // on taping her usually id of shope is send but as for time being .... we send the entire the cost list
              final navData = {
                "shopCost": dummyShopePriceList[0],
                "pdfFile": file
              };

              Navigator.of(context)
                  .pushNamed(PdfFilters.routeName, arguments: navData);
            },
            child: const Card(
              child: ListTile(
                title: Text("Vachira Xerox"),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
