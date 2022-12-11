import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pdf/widgets.dart' as pdwd;
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:xerox/utils/color_pallets.dart';

import '../../model/ListShopes.dart';
import '../../model/pdf_filters.dart';

enum PageOrientation {
  landScape,
  potrait;
}

enum PritingSides {
  singleSided,
  doubleSided,
}

enum TransparentPaperColor { blue, green, brow, purple }

enum JobTypes { blackAndWhite, fullColor, partialColor }

enum SizeOfSheets { legal, letter, a0, a1, a2, a3, a4, a5 }

class PdfFilters extends StatefulWidget {
  static const routeName = "/filterspdf";
  const PdfFilters({super.key});

  @override
  State<PdfFilters> createState() => _PdfFiltersState();
}

class _PdfFiltersState extends State<PdfFilters> {
  PdfFiltersModal currentPdfModal = PdfFiltersModal(
      pagesRange: '1-3',
      noOfCopies: '1',
      pageOrient: PageOrientation.potrait,
      pagePrintSide: PritingSides.singleSided,
      pageSize: 'A4',
      printJobType: JobTypes.blackAndWhite,
      colorPagesRange: null,
      bindingType: "NoBound",
      isBondPaperNeeded: false,
      bondPaperRange: null,
      isTransparentSheetNeed: false,
      transparentSheetColor: null,
      seletedShop: dummyShopePriceList[0]);

  final _pagesController = TextEditingController();
  final _noPagesController = TextEditingController();
  final _ColorPagesController = TextEditingController();
  final _bondPagesController = TextEditingController();

  double totalPrice = 0;

  int? totalPages = 50;

  bool showSlider = false;
  bool showwidgetSlider = false;
  bool boudSheets = false;
  bool needTransparent = false;
  bool showTranparentSheetClour = false;

  PritingSides pagePrint = PritingSides.singleSided;
  PageOrientation pageOri = PageOrientation.potrait;
  JobTypes printjob = JobTypes.blackAndWhite;
  TransparentPaperColor transpaperclr = TransparentPaperColor.blue;

  bool showColorsliderTextbox = false;
  bool showColorWidgetSliderTextBox = false;
  bool showColorTextBox = false;
  bool showWidgetColorTextBox = false;

  bool showBondSheetsTextBox = false;
  bool showBondWingetSheetsTextBox = false;
  bool showBondSheetsSliderTextBox = false;
  bool showBondSheetWidgetsliderTextBox = false;
  // SizeOfSheets sheetsSize = SizeOfSheets.a4;

  final sheetsSizeList = [
    "Legal",
    "Letter",
    "A0",
    "A1",
    "A2",
    "A3",
    "A4",
    "A5",
  ];

  final sheetsBondList = [
    "No Bound",
    "Spiral Bound",
    "Stick File",
    "Hard Bound"
  ];

  String? sheetBind;
  String? sheetsSize;

  double? contHeight;
  double? transparentContHeigt;

  double? sliderContHeight;
  double? totalPrintingContainerHeight;

  double? BondPapersliderContHeight;
  double? totalBondPaperContainerHeight;

  SfRangeValues? values;
  SfRangeValues? Colorvalues;
  SfRangeValues? Bondvalues;
  // potraint and landscape

  @override
  void initState() {
    currentPdfModal = PdfFiltersModal(
        pagesRange: _pagesController.text,
        noOfCopies: _noPagesController.text,
        pageOrient: PageOrientation.potrait,
        pagePrintSide: PritingSides.singleSided,
        pageSize: 'A4',
        printJobType: JobTypes.blackAndWhite,
        colorPagesRange: null,
        bindingType: "NoBound",
        isBondPaperNeeded: false,
        bondPaperRange: null,
        isTransparentSheetNeed: false,
        transparentSheetColor: null,
        seletedShop: dummyShopePriceList[0]);
    totalPrice = currentPdfModal.getCostOfXerox();
    _ColorPagesController.addListener(() => setState(() {}));
    _pagesController.addListener(() => setState(() {}));
    _noPagesController.addListener(() => setState(() {}));
    _bondPagesController.addListener(() => setState(() {}));

    values = SfRangeValues(1, totalPages);
    Colorvalues = SfRangeValues(1, totalPages);
    Bondvalues = SfRangeValues(1, totalPages);
    showSlider = false;
    showwidgetSlider = false;

    needTransparent = false;
    showTranparentSheetClour = false;

    boudSheets = false;

    showColorTextBox = false;
    showWidgetColorTextBox = false;
    showColorsliderTextbox = false;
    showColorWidgetSliderTextBox = false;

    sheetsSize = sheetsSizeList[6];

    showBondSheetsTextBox = false;
    showBondWingetSheetsTextBox = false;
    showBondSheetsSliderTextBox = false;
    showBondSheetWidgetsliderTextBox = false;
    super.initState();
  }

  @override
  void dispose() {
    _pagesController.dispose();
    _ColorPagesController.dispose();
    _noPagesController.dispose();
    _bondPagesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // height of page text files
    contHeight = showSlider as bool ? 140 : 70;

    transparentContHeigt = needTransparent ? 150 : 70;

    // heights for color options

    BondPapersliderContHeight = showBondSheetsTextBox
        ? showBondSheetsSliderTextBox
            ? 140
            : 70
        : 0;
    totalBondPaperContainerHeight = showBondSheetsTextBox
        ? showBondSheetsSliderTextBox
            ? 190
            : 120
        : 70;

    sliderContHeight = showColorTextBox
        ? showColorsliderTextbox
            ? 130
            : 70
        : 0;
    totalPrintingContainerHeight = showColorTextBox
        ? showColorsliderTextbox
            ? 190
            : 120
        : 70;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView(children: [
          // pages ranges
          pagesWidget(),

          // no .of copies
          no_of_copies(),

          // printing layout // toggle button
          printingLayout(),

          // pages sides ...single or double
          priting_sides(),

          // size od sheets
          size_of_pages(),

          //Print Job types
          priting_job(),

          //Binding
          binding(),

          // Bonded sheet
          bondSheets(),

          // transparent sheet
          transparentSheets(),

          const SizedBox(
            height: 50,
          )
        ]),
      ),
      bottomSheet: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: ColorPallets.lightBlue.withOpacity(.1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(22),
              topRight: Radius.circular(22),
            ),
            boxShadow: [
              BoxShadow(
                color: ColorPallets.lightBlue.withOpacity(.1),
                blurRadius: 20,
              )
            ]),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Chip(
              backgroundColor: ColorPallets.deepBlue,
              label: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                  child: Text(
                    "$totalPrice Ruppes",
                    style: const TextStyle(
                        fontSize: 20, color: ColorPallets.white),
                  )),
            ),
            const SizedBox(
              width: 30,
            ),
            InkWell(
              onTap: () {
                print(currentPdfModal.getCostOfXerox());
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      // color: ColorPallets.deepBlue,
                      borderRadius: BorderRadius.circular(18)),
                  child: Row(
                    children: const [
                      Text(
                        "Procede",
                        style: TextStyle(
                          fontSize: 26,
                          color: ColorPallets.deepBlue,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        FontAwesomeIcons.arrowRight,
                        color: ColorPallets.deepBlue,
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        ));
  }

  Widget pagesWidget() {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: AnimatedContainer(
          height: contHeight,
          duration: const Duration(milliseconds: 300),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Pages :",
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 160,
                    height: 40,
                    padding: const EdgeInsets.all(0),
                    child: TextField(
                      onSubmitted: (value) {
                        setState(() {
                          currentPdfModal = PdfFiltersModal(
                              pagesRange: _pagesController.text,
                              noOfCopies: _noPagesController.text,
                              pageOrient: PageOrientation.potrait,
                              pagePrintSide: PritingSides.singleSided,
                              pageSize: 'A4',
                              printJobType: JobTypes.blackAndWhite,
                              colorPagesRange: null,
                              bindingType: "NoBound",
                              isBondPaperNeeded: false,
                              bondPaperRange: null,
                              isTransparentSheetNeed: false,
                              transparentSheetColor: null,
                              seletedShop: dummyShopePriceList[0]);
                          totalPrice = currentPdfModal.getCostOfXerox();
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          currentPdfModal = PdfFiltersModal(
                              pagesRange: _pagesController.text,
                              noOfCopies: _noPagesController.text,
                              pageOrient: PageOrientation.potrait,
                              pagePrintSide: PritingSides.singleSided,
                              pageSize: 'A4',
                              printJobType: JobTypes.blackAndWhite,
                              colorPagesRange: null,
                              bindingType: "NoBound",
                              isBondPaperNeeded: false,
                              bondPaperRange: null,
                              isTransparentSheetNeed: false,
                              transparentSheetColor: null,
                              seletedShop: dummyShopePriceList[0]);
                          totalPrice = currentPdfModal.getCostOfXerox();
                        });
                      },
                      controller: _pagesController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(fontSize: 22),
                          hintText: "eg : 1-5,8,11-15"),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (showSlider == false) {
                        setState(() {
                          showSlider = true;
                        });
                        await Future.delayed(const Duration(milliseconds: 300));
                        setState(() {
                          showwidgetSlider = true;
                        });
                      } else {
                        setState(() {
                          showSlider = false;
                          showwidgetSlider = false;
                        });
                      }
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Chip(
                        label: Text(
                          "Slider",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        backgroundColor: ColorPallets.deepBlue,
                      ),
                    ),
                  )
                ],
              ),
              showwidgetSlider as bool == true
                  ? SingleChildScrollView(
                      child: SizedBox(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              '0',
                              style: TextStyle(
                                  fontSize: 22, color: ColorPallets.deepBlue),
                            ),
                            Expanded(
                              child: SfRangeSliderTheme(
                                data: SfRangeSelectorThemeData(
                                    tooltipBackgroundColor:
                                        ColorPallets.deepBlue),
                                child: SfRangeSlider(
                                  min: 1.0,
                                  max: totalPages!.toDouble(),
                                  enableTooltip: true,
                                  stepSize: 1,
                                  tooltipShape: const SfPaddleTooltipShape(),
                                  values: values as SfRangeValues,
                                  onChanged: (value) => setState(() {
                                    values = value;
                                    if (values!.start == values!.end) {
                                      String tempString = values!.start.toInt();
                                      _pagesController.text = tempString;
                                    } else {
                                      String tempString =
                                          "${values!.start.toInt()}-${values!.end.toInt()}";
                                      _pagesController.text = tempString;
                                    }
                                  }),
                                ),
                              ),
                            ),
                            Text(
                              totalPages.toString(),
                              style: const TextStyle(
                                  fontSize: 22, color: ColorPallets.deepBlue),
                            )
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget no_of_copies() {
    return Card(
      elevation: 3,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              const Text(
                "no.of copies  :",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 160,
                height: 40,
                padding: const EdgeInsets.all(0),
                child: TextField(
                  onSubmitted: (value) {
                    setState(() {
                      currentPdfModal = PdfFiltersModal(
                          pagesRange: _pagesController.text,
                          noOfCopies: _noPagesController.text,
                          pageOrient: PageOrientation.potrait,
                          pagePrintSide: PritingSides.singleSided,
                          pageSize: 'A4',
                          printJobType: JobTypes.blackAndWhite,
                          colorPagesRange: null,
                          bindingType: "NoBound",
                          isBondPaperNeeded: false,
                          bondPaperRange: null,
                          isTransparentSheetNeed: false,
                          transparentSheetColor: null,
                          seletedShop: dummyShopePriceList[0]);
                      totalPrice = currentPdfModal.getCostOfXerox();
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      currentPdfModal = PdfFiltersModal(
                          pagesRange: _pagesController.text,
                          noOfCopies: _noPagesController.text,
                          pageOrient: PageOrientation.potrait,
                          pagePrintSide: PritingSides.singleSided,
                          pageSize: 'A4',
                          printJobType: JobTypes.blackAndWhite,
                          colorPagesRange: null,
                          bindingType: "NoBound",
                          isBondPaperNeeded: false,
                          bondPaperRange: null,
                          isTransparentSheetNeed: false,
                          transparentSheetColor: null,
                          seletedShop: dummyShopePriceList[0]);
                      totalPrice = currentPdfModal.getCostOfXerox();
                    });
                  },
                  keyboardType: TextInputType.number,
                  controller: _noPagesController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(fontSize: 22),
                      hintText: "eg : 1"),
                ),
              )
            ],
          )),
    );
  }

  Widget printingLayout() {
    return Card(
      elevation: 3,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              const Text(
                "Printing Layout  :",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(28)),
                width: 150,
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageOri = PageOrientation.potrait;
                          });
                        },
                        child: Container(
                          height: 40,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                          decoration: BoxDecoration(
                            color: pageOri == PageOrientation.potrait
                                ? ColorPallets.lightBlue.withOpacity(.2)
                                : null,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(22),
                                bottomLeft: Radius.circular(22)),
                            border: Border.all(color: ColorPallets.lightBlue),
                          ),
                          child: const FittedBox(
                            child: Text("Potraint"),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageOri = PageOrientation.landScape;
                          });
                        },
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 9),
                          decoration: BoxDecoration(
                            color: pageOri == PageOrientation.landScape
                                ? ColorPallets.lightBlue.withOpacity(.2)
                                : null,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(22),
                                bottomRight: Radius.circular(22)),
                            border: Border.all(color: ColorPallets.lightBlue),
                          ),
                          child: const FittedBox(
                            child: Text("LandScape"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // child: Text("fdf")
              ),
            ],
          )),
    );
  }

  Widget priting_sides() {
    return Card(
      elevation: 3,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              const Text(
                "Priting Side :",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(28)),
                  width: 150,
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              pagePrint = PritingSides.singleSided;
                            });
                          },
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            decoration: BoxDecoration(
                              color: pagePrint == PritingSides.singleSided
                                  ? ColorPallets.lightBlue.withOpacity(.2)
                                  : null,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(22),
                                  bottomLeft: Radius.circular(22)),
                              border: Border.all(color: ColorPallets.lightBlue),
                            ),
                            child: const FittedBox(
                              child: Text("Single side"),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              pagePrint = PritingSides.doubleSided;
                            });
                          },
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 7),
                            decoration: BoxDecoration(
                              color: pagePrint == PritingSides.doubleSided
                                  ? ColorPallets.lightBlue.withOpacity(.2)
                                  : null,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(22),
                                  bottomRight: Radius.circular(22)),
                              border: Border.all(color: ColorPallets.lightBlue),
                            ),
                            child: const FittedBox(
                              child: Text("double side"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // child: Text("fdf")
                ),
              ),
            ],
          )),
    );
  }

  Widget size_of_pages() {
    return Card(
      elevation: 3,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const Text(
            "Size of pages :",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              width: 100,
              height: 40,
              padding: EdgeInsets.only(left: 40, top: 2, bottom: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ColorPallets.lightBlue, width: 1)),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                value: sheetsSize,
                items: sheetsSizeList.map((e) => buildMenuItem(e)).toList(),
                onChanged: (value) => setState(() {
                  sheetsSize = value;
                }),
              )),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ]),
      ),
    );
  }

  Widget priting_job() {
    return Card(
      elevation: 3,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: totalPrintingContainerHeight,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Printing JOB :",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(28)),
                    width: 150,
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                printjob = JobTypes.blackAndWhite;
                                showColorTextBox = false;
                                showWidgetColorTextBox = false;
                                showColorsliderTextbox = false;
                                showColorWidgetSliderTextBox = false;
                              });
                            },
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 7),
                              decoration: BoxDecoration(
                                color: printjob == JobTypes.blackAndWhite
                                    ? ColorPallets.lightBlue.withOpacity(.2)
                                    : null,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(22),
                                    bottomLeft: Radius.circular(22)),
                                border:
                                    Border.all(color: ColorPallets.lightBlue),
                              ),
                              child: const FittedBox(
                                child: Text("B&W"),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                printjob = JobTypes.fullColor;
                                showColorTextBox = false;
                                showWidgetColorTextBox = false;
                                showColorsliderTextbox = false;
                                showColorWidgetSliderTextBox = false;
                              });
                            },
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 7),
                              decoration: BoxDecoration(
                                color: printjob == JobTypes.fullColor
                                    ? ColorPallets.lightBlue.withOpacity(.2)
                                    : null,
                                // borderRadius: const BorderRadius.only(
                                //     topRight: Radius.circular(22),
                                //     bottomRight: Radius.circular(22)),
                                border:
                                    Border.all(color: ColorPallets.lightBlue),
                              ),
                              child: const FittedBox(
                                child: Text("Color"),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                printjob = JobTypes.partialColor;
                              });
                              if (showColorTextBox == false) {
                                setState(() {
                                  showColorTextBox = true;
                                });
                                await Future.delayed(
                                    const Duration(milliseconds: 300));
                                setState(() {
                                  showWidgetColorTextBox = true;
                                });
                              } else {
                                setState(() {
                                  showColorTextBox = false;
                                  showWidgetColorTextBox = false;
                                });
                              }
                              print("expanded the widege !!!");
                            },
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 7),
                              decoration: BoxDecoration(
                                color: printjob == JobTypes.partialColor
                                    ? ColorPallets.lightBlue.withOpacity(.2)
                                    : null,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(22),
                                    bottomRight: Radius.circular(22)),
                                border:
                                    Border.all(color: ColorPallets.lightBlue),
                              ),
                              child: const FittedBox(
                                child: Text("ColPar"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // child: Text("fdf")
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
            showWidgetColorTextBox == true
                ? AnimatedContainer(
                    padding: EdgeInsets.only(top: 10),
                    height: sliderContHeight,
                    duration: const Duration(milliseconds: 300),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Color Pages :",
                              style: TextStyle(fontSize: 22),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 90,
                              height: 40,
                              padding: const EdgeInsets.all(0),
                              child: TextField(
                                controller: _ColorPagesController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintStyle: TextStyle(fontSize: 22),
                                    hintText: "1-5,8"),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                if (showColorsliderTextbox == false) {
                                  setState(() {
                                    showColorsliderTextbox = true;
                                  });
                                  await Future.delayed(
                                      const Duration(milliseconds: 300));
                                  setState(() {
                                    showColorWidgetSliderTextBox = true;
                                  });
                                } else {
                                  setState(() {
                                    showColorsliderTextbox = false;
                                    showColorWidgetSliderTextBox = false;
                                  });
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                child: Chip(
                                  label: Text(
                                    "Slider",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  backgroundColor: ColorPallets.deepBlue,
                                ),
                              ),
                            )
                          ],
                        ),
                        showColorWidgetSliderTextBox == true
                            ? SingleChildScrollView(
                                child: SizedBox(
                                  height: 70,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text(
                                        '0',
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: ColorPallets.deepBlue),
                                      ),
                                      Expanded(
                                        child: SfRangeSliderTheme(
                                          data: SfRangeSelectorThemeData(
                                              tooltipBackgroundColor:
                                                  ColorPallets.deepBlue),
                                          child: SfRangeSlider(
                                            key: ValueKey("colorpagesClider"),
                                            min: 1,
                                            max: totalPages!.toDouble(),
                                            enableTooltip: true,
                                            stepSize: 1,
                                            tooltipShape:
                                                const SfPaddleTooltipShape(),
                                            values:
                                                Colorvalues as SfRangeValues,
                                            onChanged: (value) => setState(() {
                                              Colorvalues = value;
                                              if (Colorvalues!.start ==
                                                  Colorvalues!.end) {
                                                String tempString =
                                                    "${Colorvalues!.start}";
                                                _ColorPagesController.text =
                                                    tempString;
                                              } else {
                                                String tempString =
                                                    "${Colorvalues!.start}-${Colorvalues!.end}";
                                                _ColorPagesController.text =
                                                    tempString;
                                              }
                                            }),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        totalPages.toString(),
                                        style: const TextStyle(
                                            fontSize: 22,
                                            color: ColorPallets.deepBlue),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget binding() {
    return Card(
      elevation: 3,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const Text(
            "Binding :",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              width: 100,
              height: 40,
              padding: EdgeInsets.only(left: 40, top: 2, bottom: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ColorPallets.lightBlue, width: 1)),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                value: sheetBind,
                items: sheetsBondList.map((e) => buildMenuItem(e)).toList(),
                onChanged: (value) => setState(() {
                  sheetBind = value;
                }),
              )),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ]),
      ),
    );
  }

  Widget bondSheets() {
    return Card(
      elevation: 3,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: totalBondPaperContainerHeight,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "BondPaper :",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(28)),
                    width: 150,
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                boudSheets = false;
                                showBondSheetsTextBox = false;
                                showBondWingetSheetsTextBox = false;
                                showBondSheetsSliderTextBox = false;
                                showBondSheetWidgetsliderTextBox = false;
                              });
                            },
                            child: Container(
                              height: 40,
                              // padding: const EdgeInsets.symmetric(
                              //     horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: boudSheets == false
                                    ? ColorPallets.lightBlue.withOpacity(.2)
                                    : null,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(22),
                                    bottomLeft: Radius.circular(22)),
                                border:
                                    Border.all(color: ColorPallets.lightBlue),
                              ),
                              child: const Center(
                                child: Text(
                                  "No",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                boudSheets = true;
                              });
                              if (showBondSheetsTextBox == false) {
                                setState(() {
                                  showBondSheetsTextBox = true;
                                });
                                await Future.delayed(
                                    const Duration(milliseconds: 300));
                                setState(() {
                                  showBondWingetSheetsTextBox = true;
                                });
                              } else {
                                setState(() {
                                  showBondSheetsTextBox = false;
                                  showBondWingetSheetsTextBox = false;
                                });
                              }
                              print("expanded the widege !!!");
                            },
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              decoration: BoxDecoration(
                                color: boudSheets == true
                                    ? ColorPallets.lightBlue.withOpacity(.2)
                                    : null,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(22),
                                    bottomRight: Radius.circular(22)),
                                border:
                                    Border.all(color: ColorPallets.lightBlue),
                              ),
                              child: const Center(
                                child: Text(
                                  "Yes",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // child: Text("fdf")
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
            showBondWingetSheetsTextBox == true
                ? AnimatedContainer(
                    padding: EdgeInsets.only(top: 10),
                    height: BondPapersliderContHeight,
                    duration: const Duration(milliseconds: 300),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Color Pages :",
                              style: TextStyle(fontSize: 22),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 90,
                              height: 30,
                              padding: const EdgeInsets.all(0),
                              child: TextField(
                                controller: _bondPagesController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintStyle: TextStyle(fontSize: 22),
                                    hintText: "1-5,8"),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                if (showBondSheetsSliderTextBox == false) {
                                  setState(() {
                                    showBondSheetsSliderTextBox = true;
                                  });
                                  await Future.delayed(
                                      const Duration(milliseconds: 300));
                                  setState(() {
                                    showBondSheetWidgetsliderTextBox = true;
                                  });
                                } else {
                                  setState(() {
                                    showBondSheetsSliderTextBox = false;
                                    showBondSheetWidgetsliderTextBox = false;
                                  });
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Chip(
                                  label: Text(
                                    "Slider",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  backgroundColor: ColorPallets.deepBlue,
                                ),
                              ),
                            )
                          ],
                        ),
                        showBondSheetWidgetsliderTextBox == true
                            ? SingleChildScrollView(
                                child: SizedBox(
                                  height: 70,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text(
                                        '0',
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: ColorPallets.deepBlue),
                                      ),
                                      Expanded(
                                        child: SfRangeSliderTheme(
                                          data: SfRangeSelectorThemeData(
                                              tooltipBackgroundColor:
                                                  ColorPallets.deepBlue),
                                          child: SfRangeSlider(
                                            min: 1,
                                            max: totalPages!.toDouble(),
                                            enableTooltip: true,
                                            stepSize: 1,
                                            tooltipShape:
                                                const SfPaddleTooltipShape(),
                                            values: Bondvalues as SfRangeValues,
                                            onChanged: (value) => setState(() {
                                              Bondvalues = value;
                                              if (Bondvalues!.start ==
                                                  Bondvalues!.end) {
                                                String tempString =
                                                    "${Bondvalues!.start}";
                                                _bondPagesController.text =
                                                    tempString;
                                              } else {
                                                String tempString =
                                                    "${Bondvalues!.start}-${Bondvalues!.end}";
                                                _bondPagesController.text =
                                                    tempString;
                                              }
                                            }),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        totalPages.toString(),
                                        style: const TextStyle(
                                            fontSize: 22,
                                            color: ColorPallets.deepBlue),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget transparentSheets() {
    return Card(
      elevation: 3,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: transparentContHeigt,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              const Text(
                "transparentSheet :",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () async {
                    setState(() {
                      needTransparent = true;
                    });
                    await Future.delayed(Duration(milliseconds: 300));
                    setState(() {
                      showTranparentSheetClour = true;
                    });
                  },
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.only(),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorPallets.lightBlue),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(22),
                        bottomLeft: Radius.circular(22),
                      ),
                      color: needTransparent == true
                          ? ColorPallets.lightBlue.withOpacity(.2)
                          : null,
                    ),
                    child: const Center(
                        child: Text(
                      "Yes",
                      style: TextStyle(fontSize: 20),
                    )),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      needTransparent = false;
                      showTranparentSheetClour = false;
                    });
                  },
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.only(),
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorPallets.lightBlue),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(22),
                          bottomRight: Radius.circular(22),
                        ),
                        color: needTransparent == false
                            ? ColorPallets.lightBlue.withOpacity(.2)
                            : null),
                    child: const Center(
                        child: Text(
                      "No",
                      style: TextStyle(fontSize: 20),
                    )),
                  ),
                ),
              ),
              const SizedBox(
                width: 0,
              )
            ]),
            const SizedBox(
              height: 10,
            ),
            showTranparentSheetClour
                ? Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              transpaperclr = TransparentPaperColor.blue;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                border:
                                    transpaperclr == TransparentPaperColor.blue
                                        ? Border.all(
                                            color: ColorPallets.lightBlue,
                                            width: 2)
                                        : null,
                                borderRadius: BorderRadius.circular(12),
                                color:
                                    transpaperclr == TransparentPaperColor.blue
                                        ? Colors.lightBlueAccent
                                        : Colors.lightBlueAccent.shade100),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                            onTap: () {
                              setState(() {
                                transpaperclr = TransparentPaperColor.green;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: transpaperclr ==
                                          TransparentPaperColor.green
                                      ? Border.all(
                                          color: Colors.lightGreen, width: 2)
                                      : null,
                                  color: transpaperclr ==
                                          TransparentPaperColor.green
                                      ? Colors.lightGreenAccent
                                      : Colors.lightGreenAccent.shade100),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              transpaperclr = TransparentPaperColor.brow;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                border: transpaperclr ==
                                        TransparentPaperColor.brow
                                    ? Border.all(color: Colors.brown, width: 2)
                                    : null,
                                borderRadius: BorderRadius.circular(12),
                                color:
                                    transpaperclr == TransparentPaperColor.brow
                                        ? Colors.brown
                                        : Colors.brown.shade200),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              transpaperclr = TransparentPaperColor.purple;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                border: transpaperclr ==
                                        TransparentPaperColor.purple
                                    ? Border.all(
                                        color: Colors.deepPurpleAccent,
                                        width: 2)
                                    : null,
                                borderRadius: BorderRadius.circular(12),
                                color: transpaperclr ==
                                        TransparentPaperColor.purple
                                    ? Colors.deepPurpleAccent
                                    : Colors.deepPurpleAccent.shade100),
                          ),
                        )
                      ],
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
