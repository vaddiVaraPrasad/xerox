import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xerox/utils/color_pallets.dart';

class PdfFilters extends StatefulWidget {
  static const routeName = "/pdffilters";
  const PdfFilters({super.key});

  @override
  State<PdfFilters> createState() => _PdfFiltersState();
}

class _PdfFiltersState extends State<PdfFilters> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  int pagesCount = 1;
  double cost = 45.34;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add filteres")),
      body: Scrollbar(
        child: Padding(
          padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
          child: ListView(
            children: [],
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: ColorPallets.lightPurple.withOpacity(.5),
                  offset: const Offset(0, 0),
                  blurRadius: 50,
                  blurStyle: BlurStyle.outer)
            ],
            color: ColorPallets.lightPurple.withOpacity(.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            )),
        height: 200,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Row(children: []),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 10, right: 5, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Chip(
                      label: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 10,
                        ),
                        child: Text(
                          "${cost.toString()} Rupess",
                          style: const TextStyle(
                              color: ColorPallets.white, fontSize: 20),
                        ),
                      ),
                      backgroundColor: ColorPallets.deepBlue,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                "Preview it",
                                style: TextStyle(fontSize: 28),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                FontAwesomeIcons.arrowRight,
                                size: 26,
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
