import 'dart:io';

import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pdf/widgets.dart' as pdwd;
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:xerox/utils/color_pallets.dart';

import '../../Provider/current_order.dart';
import '../../Provider/selected_shop.dart';
import '../../model/pdf_filters.dart';
import '../drawer_Screens/history_order_screen.dart';
import 'Order_Preview.dart';
import '../navBar_Screens/home_screen.dart';
import '../nav_drawers/hidden_drawer.dart';
import '../nav_drawers/navBar.dart';

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

String getStringPrintingSides(PritingSides side) {
  if (side == PritingSides.singleSided) {
    return "Single Side";
  }
  return "Double Side";
}

String getStringSizeOfSheet(SizeOfSheets size) {
  if (size == SizeOfSheets.legal) {
    return "Legal";
  } else if (size == SizeOfSheets.letter) {
    return "Letter";
  } else if (size == SizeOfSheets.a0) {
    return "A0";
  } else if (size == SizeOfSheets.a1) {
    return "A1";
  } else if (size == SizeOfSheets.a3) {
    return "A3";
  } else if (size == SizeOfSheets.a4) {
    return "A4";
  }
  return "A5";
}

String getStringPageOrientations(PageOrientation orient) {
  if (orient == PageOrientation.landScape) {
    return "Landscape";
  } else {
    return "Potrait";
  }
}

String getStringTransparentPaperColor(TransparentPaperColor color) {
  if (color == TransparentPaperColor.blue) {
    return "Blue";
  } else if (color == TransparentPaperColor.green) {
    return "Green";
  } else if (color == TransparentPaperColor.brow) {
    return "Brown";
  }
  return "Purple";
}

String getStringJobTypes(JobTypes job) {
  if (job == JobTypes.blackAndWhite) {
    return "Black And White";
  } else if (job == JobTypes.fullColor) {
    return "Full Color";
  }
  return "Partial Color";
}

class PdfFilters extends StatefulWidget {
  static const routeName = "/filterspdf";
  const PdfFilters({super.key});

  @override
  State<PdfFilters> createState() => _PdfFiltersState();
}

class _PdfFiltersState extends State<PdfFilters> {
  // PdfFiltersModal currentPdfModal = PdfFiltersModal(
  //     pagesRange: '1-3',
  //     noOfCopies: '1',
  //     pageOrient: PageOrientation.potrait,
  //     pagePrintSide: PritingSides.singleSided,
  //     pageSize: 'A4',
  //     printJobType: JobTypes.blackAndWhite,
  //     colorPagesRange: "",
  //     bindingType: "No Bound",
  //     isBondPaperNeeded: false,
  //     bondPaperRange: "",
  //     isTransparentSheetNeed: false,
  //     transparentSheetColor: "",
  //     seletedShop: dummyShopePriceList[0]);
  PdfFiltersModal? currentPdfModal;

  final _pagesController = TextEditingController();
  final _noPagesController = TextEditingController();
  final _ColorPagesController = TextEditingController();
  final _bondPagesController = TextEditingController();

  double totalPrice = 0;

  int? totalPages = 0;

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

  bool isInit = true;
  File? file;

  String? fileName;
  @override
  void initState() {
    // print("height is ${MediaQuery.of(context).size.height}");
    // print("width is ${MediaQuery.of(context).size.width}");

    // currentPdfModal = PdfFiltersModal(
    //     pagesRange: _pagesController.text,
    //     noOfCopies: _noPagesController.text,
    //     pageOrient: PageOrientation.potrait,
    //     pagePrintSide: PritingSides.singleSided,
    //     pageSize: 'A4',
    //     printJobType: JobTypes.blackAndWhite,
    //     colorPagesRange: "",
    //     bindingType: "NoBound",
    //     isBondPaperNeeded: false,
    //     bondPaperRange: "",
    //     isTransparentSheetNeed: false,
    //     transparentSheetColor: "",
    //     seletedShop: dummyShopePriceList[0]);

    _ColorPagesController.addListener(() => setState(() {}));
    _pagesController.addListener(() => setState(() {}));
    _noPagesController.addListener(() => setState(() {}));
    _bondPagesController.addListener(() => setState(() {}));

    values = SfRangeValues(0, totalPages);
    Colorvalues = SfRangeValues(0, totalPages);
    Bondvalues = SfRangeValues(0, totalPages);
    showSlider = false;
    showwidgetSlider = false;

    needTransparent = false;
    showTranparentSheetClour = false;

    boudSheets = false;

    sheetBind = "No Bound";

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
  void didChangeDependencies() {
    if (isInit) {
      CurrentOrder curOrder = Provider.of<CurrentOrder>(context);
      file = curOrder.getPdfFile;
      fileName = curOrder.getPdfFileName;
      PdfDocument document = PdfDocument(inputBytes: file!.readAsBytesSync());
      SelectedShop selectedShopProvider = Provider.of<SelectedShop>(context);

//Gets the pages count
      totalPages = document.pages.count;
      print("page count in didchange depedence is $totalPages");

      values = SfRangeValues(1, totalPages);
      Colorvalues = SfRangeValues(1, totalPages);
      Bondvalues = SfRangeValues(1, totalPages);
      _pagesController.text = "1-$totalPages";
      _ColorPagesController.text = "1-$totalPages";
      _bondPagesController.text = "1-$totalPages";
      _noPagesController.text = "1";
      currentPdfModal = PdfFiltersModal(
          pagesRange: _pagesController.text,
          noOfCopies: _noPagesController.text,
          pageOrient: PageOrientation.potrait,
          pagePrintSide: PritingSides.singleSided,
          pageSize: 'A4',
          printJobType: JobTypes.blackAndWhite,
          colorPagesRange: "",
          bindingType: "NoBound",
          isBondPaperNeeded: false,
          bondPaperRange: "",
          isTransparentSheetNeed: false,
          transparentSheetColor: "",
          seletedShop: selectedShopProvider.getSeletedShop());

      totalPrice = currentPdfModal!.getCostOfXerox();
//Disposes the document
      document.dispose();
    }
    super.didChangeDependencies();
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
    CurrentOrder curOrder = Provider.of<CurrentOrder>(context);
    // height of page text files
    contHeight = showSlider ? 140 : 70;

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
            : 58
        : 0;
    totalPrintingContainerHeight = showColorTextBox
        ? showColorsliderTextbox
            ? 190
            : 120
        : 70;

    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Filter the PDf",
        style: TextStyle(color: ColorPallets.white),
      )),
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
                  child: FittedBox(
                    child: Text(
                      // ignore: unnecessary_brace_in_string_interps
                      "${totalPrice.toStringAsFixed(2)} Rs",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20, color: ColorPallets.white),
                    ),
                  )),
            ),
            const SizedBox(
              width: 30,
            ),
            InkWell(
              onTap: () {
                curOrder.setPdfFilterDetails(
                    currentPdfModal!.pagesRange,
                    PdfFiltersModal.getPagesCount(currentPdfModal!.pagesRange)
                        .toString(),
                    currentPdfModal!.noOfCopies,
                    getStringPageOrientations(currentPdfModal!.pageOrient),
                    getStringPrintingSides(currentPdfModal!.pagePrintSide),
                    currentPdfModal!.pageSize,
                    getStringJobTypes(currentPdfModal!.printJobType),
                    currentPdfModal!.colorPagesRange,
                    PdfFiltersModal.getPagesCount(
                            currentPdfModal!.colorPagesRange)
                        .toString(),
                    currentPdfModal!.bindingType,
                    currentPdfModal!.isBondPaperNeeded.toString(),
                    currentPdfModal!.bondPaperRange,
                    currentPdfModal!.isTransparentSheetNeed.toString(),
                    currentPdfModal!.transparentSheetColor,
                    currentPdfModal!.getCostOfXerox().toString());
                Navigator.of(context)
                    .pushReplacementNamed(OrderPreviewScreen.routeName);
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      // color: ColorPallets.deepBlue,
                      borderRadius: BorderRadius.circular(18)),
                  child: Row(
                    children: const [
                      FittedBox(
                        child: Text(
                          "Procede",
                          style: TextStyle(
                            fontSize: 26,
                            color: ColorPallets.deepBlue,
                          ),
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
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      child: const Center(
                        child: FittedBox(
                          child: Text(
                            "Pages :",
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        cursorHeight: 25,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (value) {
                          setState(() {
                            currentPdfModal = PdfFiltersModal(
                                pagesRange: _pagesController.text,
                                noOfCopies: currentPdfModal!.noOfCopies,
                                pageOrient: currentPdfModal!.pageOrient,
                                pagePrintSide: currentPdfModal!.pagePrintSide,
                                pageSize: currentPdfModal!.pageSize,
                                printJobType: currentPdfModal!.printJobType,
                                colorPagesRange:
                                    currentPdfModal!.colorPagesRange,
                                bindingType: currentPdfModal!.bindingType,
                                isBondPaperNeeded:
                                    currentPdfModal!.isBondPaperNeeded,
                                bondPaperRange: currentPdfModal!.bondPaperRange,
                                isTransparentSheetNeed:
                                    currentPdfModal!.isTransparentSheetNeed,
                                transparentSheetColor:
                                    currentPdfModal!.transparentSheetColor,
                                seletedShop: currentPdfModal!.seletedShop);
                            totalPrice = currentPdfModal!.getCostOfXerox();
                          });
                        },
                        controller: _pagesController,
                        decoration: const InputDecoration(
                            floatingLabelStyle: TextStyle(fontSize: 25),
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(fontSize: 18),
                            hintText: "1-5,8,11-15"),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () async {
                        if (showSlider == false) {
                          setState(() {
                            showSlider = true;
                          });
                          await Future.delayed(
                              const Duration(milliseconds: 300));
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
                        padding: EdgeInsets.only(
                            left: 3, right: 0, top: 5, bottom: 5),
                        child: Chip(
                          label: Text(
                            "Slider",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          backgroundColor: ColorPallets.deepBlue,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              showwidgetSlider == true
                  ? SingleChildScrollView(
                      child: SizedBox(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
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
                                    currentPdfModal = PdfFiltersModal(
                                        pagesRange: _pagesController.text,
                                        noOfCopies: currentPdfModal!.noOfCopies,
                                        pageOrient: currentPdfModal!.pageOrient,
                                        pagePrintSide:
                                            currentPdfModal!.pagePrintSide,
                                        pageSize: currentPdfModal!.pageSize,
                                        printJobType:
                                            currentPdfModal!.printJobType,
                                        colorPagesRange:
                                            currentPdfModal!.colorPagesRange,
                                        bindingType:
                                            currentPdfModal!.bindingType,
                                        isBondPaperNeeded:
                                            currentPdfModal!.isBondPaperNeeded,
                                        bondPaperRange:
                                            currentPdfModal!.bondPaperRange,
                                        isTransparentSheetNeed: currentPdfModal!
                                            .isTransparentSheetNeed,
                                        transparentSheetColor: currentPdfModal!
                                            .transparentSheetColor,
                                        seletedShop:
                                            currentPdfModal!.seletedShop);
                                    totalPrice =
                                        currentPdfModal!.getCostOfXerox();
                                  }),
                                ),
                              ),
                            ),
                            Text(
                              totalPages.toString(),
                              style: const TextStyle(
                                  fontSize: 22, color: ColorPallets.deepBlue),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
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
              Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  child: const Center(
                    child: FittedBox(
                      child: Text(
                        "no.of copies  :",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 5,
                child: Container(
                  height: 40,
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      setState(() {
                        currentPdfModal = PdfFiltersModal(
                            pagesRange: currentPdfModal!.pagesRange,
                            noOfCopies: _noPagesController.text,
                            pageOrient: currentPdfModal!.pageOrient,
                            pagePrintSide: currentPdfModal!.pagePrintSide,
                            pageSize: currentPdfModal!.pageSize,
                            printJobType: currentPdfModal!.printJobType,
                            colorPagesRange: currentPdfModal!.colorPagesRange,
                            bindingType: currentPdfModal!.bindingType,
                            isBondPaperNeeded:
                                currentPdfModal!.isBondPaperNeeded,
                            bondPaperRange: currentPdfModal!.bondPaperRange,
                            isTransparentSheetNeed:
                                currentPdfModal!.isTransparentSheetNeed,
                            transparentSheetColor:
                                currentPdfModal!.transparentSheetColor,
                            seletedShop: currentPdfModal!.seletedShop);
                        totalPrice = currentPdfModal!.getCostOfXerox();
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        currentPdfModal = PdfFiltersModal(
                            pagesRange: currentPdfModal!.pagesRange,
                            noOfCopies: _noPagesController.text,
                            pageOrient: currentPdfModal!.pageOrient,
                            pagePrintSide: currentPdfModal!.pagePrintSide,
                            pageSize: currentPdfModal!.pageSize,
                            printJobType: currentPdfModal!.printJobType,
                            colorPagesRange: currentPdfModal!.colorPagesRange,
                            bindingType: currentPdfModal!.bindingType,
                            isBondPaperNeeded:
                                currentPdfModal!.isBondPaperNeeded,
                            bondPaperRange: currentPdfModal!.bondPaperRange,
                            isTransparentSheetNeed:
                                currentPdfModal!.isTransparentSheetNeed,
                            transparentSheetColor:
                                currentPdfModal!.transparentSheetColor,
                            seletedShop: currentPdfModal!.seletedShop);
                        totalPrice = currentPdfModal!.getCostOfXerox();
                      });
                    },
                    cursorHeight: 25,
                    keyboardType: TextInputType.number,
                    controller: _noPagesController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontSize: 18),
                        hintText: "1 or 28"),
                  ),
                ),
              ),
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
              Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  child: const Center(
                    child: FittedBox(
                      child: Text(
                        "Printing Layout  :",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 5,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(28)),
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              pageOri = PageOrientation.potrait;
                              currentPdfModal = PdfFiltersModal(
                                  pagesRange: currentPdfModal!.pagesRange,
                                  noOfCopies: currentPdfModal!.noOfCopies,
                                  pageOrient: PageOrientation.potrait,
                                  pagePrintSide: currentPdfModal!.pagePrintSide,
                                  pageSize: currentPdfModal!.pageSize,
                                  printJobType: currentPdfModal!.printJobType,
                                  colorPagesRange:
                                      currentPdfModal!.colorPagesRange,
                                  bindingType: currentPdfModal!.bindingType,
                                  isBondPaperNeeded:
                                      currentPdfModal!.isBondPaperNeeded,
                                  bondPaperRange:
                                      currentPdfModal!.bondPaperRange,
                                  isTransparentSheetNeed:
                                      currentPdfModal!.isTransparentSheetNeed,
                                  transparentSheetColor:
                                      currentPdfModal!.transparentSheetColor,
                                  seletedShop: currentPdfModal!.seletedShop);
                              totalPrice = currentPdfModal!.getCostOfXerox();
                            });
                          },
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 7),
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
                              child: Text(
                                " Potraint  ",
                                textAlign: TextAlign.center,
                              ),
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
                              currentPdfModal = PdfFiltersModal(
                                  pagesRange: currentPdfModal!.pagesRange,
                                  noOfCopies: currentPdfModal!.noOfCopies,
                                  pageOrient: PageOrientation.landScape,
                                  pagePrintSide: currentPdfModal!.pagePrintSide,
                                  pageSize: currentPdfModal!.pageSize,
                                  printJobType: currentPdfModal!.printJobType,
                                  colorPagesRange:
                                      currentPdfModal!.colorPagesRange,
                                  bindingType: currentPdfModal!.bindingType,
                                  isBondPaperNeeded:
                                      currentPdfModal!.isBondPaperNeeded,
                                  bondPaperRange:
                                      currentPdfModal!.bondPaperRange,
                                  isTransparentSheetNeed:
                                      currentPdfModal!.isTransparentSheetNeed,
                                  transparentSheetColor:
                                      currentPdfModal!.transparentSheetColor,
                                  seletedShop: currentPdfModal!.seletedShop);
                              totalPrice = currentPdfModal!.getCostOfXerox();
                            });
                          },
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 7),
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
                              child: Text(
                                "LandScape",
                                textAlign: TextAlign.center,
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
              Expanded(
                flex: 4,
                child: Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: const Center(
                    child: FittedBox(
                      child: Text(
                        "Priting  Side  :",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 5,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(28)),
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              pagePrint = PritingSides.singleSided;
                              currentPdfModal = PdfFiltersModal(
                                  pagesRange: currentPdfModal!.pagesRange,
                                  noOfCopies: currentPdfModal!.noOfCopies,
                                  pageOrient: currentPdfModal!.pageOrient,
                                  pagePrintSide: PritingSides.singleSided,
                                  pageSize: currentPdfModal!.pageSize,
                                  printJobType: currentPdfModal!.printJobType,
                                  colorPagesRange:
                                      currentPdfModal!.colorPagesRange,
                                  bindingType: currentPdfModal!.bindingType,
                                  isBondPaperNeeded:
                                      currentPdfModal!.isBondPaperNeeded,
                                  bondPaperRange:
                                      currentPdfModal!.bondPaperRange,
                                  isTransparentSheetNeed:
                                      currentPdfModal!.isTransparentSheetNeed,
                                  transparentSheetColor:
                                      currentPdfModal!.transparentSheetColor,
                                  seletedShop: currentPdfModal!.seletedShop);
                              totalPrice = currentPdfModal!.getCostOfXerox();
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
                              child: Text(
                                "Single side",
                                textAlign: TextAlign.center,
                              ),
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
                              currentPdfModal = PdfFiltersModal(
                                  pagesRange: currentPdfModal!.pagesRange,
                                  noOfCopies: currentPdfModal!.noOfCopies,
                                  pageOrient: currentPdfModal!.pageOrient,
                                  pagePrintSide: PritingSides.doubleSided,
                                  pageSize: currentPdfModal!.pageSize,
                                  printJobType: currentPdfModal!.printJobType,
                                  colorPagesRange:
                                      currentPdfModal!.colorPagesRange,
                                  bindingType: currentPdfModal!.bindingType,
                                  isBondPaperNeeded:
                                      currentPdfModal!.isBondPaperNeeded,
                                  bondPaperRange:
                                      currentPdfModal!.bondPaperRange,
                                  isTransparentSheetNeed:
                                      currentPdfModal!.isTransparentSheetNeed,
                                  transparentSheetColor:
                                      currentPdfModal!.transparentSheetColor,
                                  seletedShop: currentPdfModal!.seletedShop);
                              totalPrice = currentPdfModal!.getCostOfXerox();
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
                              child: Text(
                                "double side",
                                textAlign: TextAlign.center,
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
            ],
          )),
    );
  }

  Widget size_of_pages() {
    return Card(
      elevation: 3,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.only(right: 5, left: 5),
              child: const Center(
                child: FittedBox(
                  child: Text(
                    "Size of pages :",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 5,
            child: Container(
              height: 40,
              padding: const EdgeInsets.only(left: 60, top: 2, bottom: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ColorPallets.lightBlue, width: 1)),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                value: sheetsSize,
                items: sheetsSizeList.map((e) => buildMenuItem(e)).toList(),
                onChanged: (value) => setState(() {
                  sheetsSize = value;
                  currentPdfModal = PdfFiltersModal(
                      pagesRange: currentPdfModal!.pagesRange,
                      noOfCopies: currentPdfModal!.noOfCopies,
                      pageOrient: currentPdfModal!.pageOrient,
                      pagePrintSide: currentPdfModal!.pagePrintSide,
                      pageSize: value.toString(),
                      printJobType: currentPdfModal!.printJobType,
                      colorPagesRange: currentPdfModal!.colorPagesRange,
                      bindingType: currentPdfModal!.bindingType,
                      isBondPaperNeeded: currentPdfModal!.isBondPaperNeeded,
                      bondPaperRange: currentPdfModal!.bondPaperRange,
                      isTransparentSheetNeed:
                          currentPdfModal!.isTransparentSheetNeed,
                      transparentSheetColor:
                          currentPdfModal!.transparentSheetColor,
                      seletedShop: currentPdfModal!.seletedShop);
                  totalPrice = currentPdfModal!.getCostOfXerox();
                }),
              )),
            ),
          ),
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
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    child: const Center(
                      child: FittedBox(
                        child: Text(
                          "Printing JOB :",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(28)),
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
                                currentPdfModal = PdfFiltersModal(
                                    pagesRange: currentPdfModal!.pagesRange,
                                    noOfCopies: currentPdfModal!.noOfCopies,
                                    pageOrient: currentPdfModal!.pageOrient,
                                    pagePrintSide:
                                        currentPdfModal!.pagePrintSide,
                                    pageSize: currentPdfModal!.pageSize,
                                    printJobType: JobTypes.blackAndWhite,
                                    colorPagesRange: "",
                                    bindingType: currentPdfModal!.bindingType,
                                    isBondPaperNeeded:
                                        currentPdfModal!.isBondPaperNeeded,
                                    bondPaperRange:
                                        currentPdfModal!.bondPaperRange,
                                    isTransparentSheetNeed:
                                        currentPdfModal!.isTransparentSheetNeed,
                                    transparentSheetColor:
                                        currentPdfModal!.transparentSheetColor,
                                    seletedShop: currentPdfModal!.seletedShop);
                                totalPrice = currentPdfModal!.getCostOfXerox();
                              });
                            },
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 7),
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
                                currentPdfModal = PdfFiltersModal(
                                    pagesRange: currentPdfModal!.pagesRange,
                                    noOfCopies: currentPdfModal!.noOfCopies,
                                    pageOrient: currentPdfModal!.pageOrient,
                                    pagePrintSide:
                                        currentPdfModal!.pagePrintSide,
                                    pageSize: currentPdfModal!.pageSize,
                                    printJobType: JobTypes.fullColor,
                                    colorPagesRange:
                                        currentPdfModal!.pagesRange,
                                    bindingType: currentPdfModal!.bindingType,
                                    isBondPaperNeeded:
                                        currentPdfModal!.isBondPaperNeeded,
                                    bondPaperRange:
                                        currentPdfModal!.bondPaperRange,
                                    isTransparentSheetNeed:
                                        currentPdfModal!.isTransparentSheetNeed,
                                    transparentSheetColor:
                                        currentPdfModal!.transparentSheetColor,
                                    seletedShop: currentPdfModal!.seletedShop);
                                totalPrice = currentPdfModal!.getCostOfXerox();
                              });
                            },
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 7),
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
                                  horizontal: 3, vertical: 7),
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
              ],
            ),
            showWidgetColorTextBox == true
                ? AnimatedContainer(
                    padding: const EdgeInsets.only(top: 10),
                    height: sliderContHeight,
                    duration: const Duration(milliseconds: 300),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: const Center(
                                  child: FittedBox(
                                    child: Text(
                                      "Color Pages :",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 40,
                                padding: const EdgeInsets.all(0),
                                child: TextField(
                                  onSubmitted: (value) {
                                    setState(() {
                                      currentPdfModal = PdfFiltersModal(
                                          pagesRange:
                                              currentPdfModal!.pagesRange,
                                          noOfCopies:
                                              currentPdfModal!.noOfCopies,
                                          pageOrient:
                                              currentPdfModal!.pageOrient,
                                          pagePrintSide:
                                              currentPdfModal!.pagePrintSide,
                                          pageSize: currentPdfModal!.pageSize,
                                          printJobType: JobTypes.partialColor,
                                          colorPagesRange:
                                              _ColorPagesController.text,
                                          bindingType:
                                              currentPdfModal!.bindingType,
                                          isBondPaperNeeded: currentPdfModal!
                                              .isBondPaperNeeded,
                                          bondPaperRange:
                                              currentPdfModal!.bondPaperRange,
                                          isTransparentSheetNeed:
                                              currentPdfModal!
                                                  .isTransparentSheetNeed,
                                          transparentSheetColor:
                                              currentPdfModal!
                                                  .transparentSheetColor,
                                          seletedShop:
                                              currentPdfModal!.seletedShop);
                                      totalPrice =
                                          currentPdfModal!.getCostOfXerox();
                                    });
                                  },
                                  controller: _ColorPagesController,
                                  cursorHeight: 25,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintStyle: TextStyle(fontSize: 18),
                                      hintText: "1-5,8"),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: InkWell(
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
                                child: Container(
                                  // padding: EdgeInsets.only(
                                  //   left: 10,
                                  // ),
                                  child: const Chip(
                                    label: Text(
                                      "Slider",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    backgroundColor: ColorPallets.deepBlue,
                                  ),
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
                                      const SizedBox(
                                        width: 10,
                                      ),
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
                                              key: const ValueKey(
                                                  "colorpagesClider"),
                                              min: 1,
                                              max: totalPages!.toDouble(),
                                              enableTooltip: true,
                                              stepSize: 1,
                                              tooltipShape:
                                                  const SfPaddleTooltipShape(),
                                              values:
                                                  Colorvalues as SfRangeValues,
                                              onChanged: (value) {
                                                setState(() {
                                                  Colorvalues = value;
                                                  if (Colorvalues!.start ==
                                                      Colorvalues!.end) {
                                                    String tempString =
                                                        "${Colorvalues!.start.toInt()}";
                                                    _ColorPagesController.text =
                                                        tempString;
                                                  } else {
                                                    String tempString =
                                                        "${Colorvalues!.start.toInt()}-${Colorvalues!.end.toInt()}";
                                                    _ColorPagesController.text =
                                                        tempString;
                                                  }
                                                });
                                                setState(() {
                                                  currentPdfModal = PdfFiltersModal(
                                                      pagesRange: currentPdfModal!
                                                          .pagesRange,
                                                      noOfCopies: currentPdfModal!
                                                          .noOfCopies,
                                                      pageOrient: currentPdfModal!
                                                          .pageOrient,
                                                      pagePrintSide: currentPdfModal!
                                                          .pagePrintSide,
                                                      pageSize: currentPdfModal!
                                                          .pageSize,
                                                      printJobType:
                                                          JobTypes.partialColor,
                                                      colorPagesRange:
                                                          _ColorPagesController
                                                              .text,
                                                      bindingType: currentPdfModal!
                                                          .bindingType,
                                                      isBondPaperNeeded:
                                                          currentPdfModal!
                                                              .isBondPaperNeeded,
                                                      bondPaperRange:
                                                          currentPdfModal!
                                                              .bondPaperRange,
                                                      isTransparentSheetNeed:
                                                          currentPdfModal!
                                                              .isTransparentSheetNeed,
                                                      transparentSheetColor:
                                                          currentPdfModal!
                                                              .transparentSheetColor,
                                                      seletedShop:
                                                          currentPdfModal!
                                                              .seletedShop);
                                                  totalPrice = currentPdfModal!
                                                      .getCostOfXerox();
                                                });
                                              }),
                                        ),
                                      ),
                                      Text(
                                        totalPages.toString(),
                                        style: const TextStyle(
                                            fontSize: 22,
                                            color: ColorPallets.deepBlue),
                                      ),
                                      const SizedBox(
                                        width: 10,
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
        height: 60,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: const Center(
                child: FittedBox(
                  child: Text(
                    "Binding :",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 5,
            child: Container(
              height: 40,
              padding: const EdgeInsets.only(left: 20, top: 2, bottom: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ColorPallets.lightBlue, width: 1)),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                value: sheetBind,
                items: sheetsBondList.map((e) => buildMenuItem(e)).toList(),
                onChanged: (value) => setState(() {
                  sheetBind = value;
                  currentPdfModal = PdfFiltersModal(
                      pagesRange: currentPdfModal!.pagesRange,
                      noOfCopies: currentPdfModal!.noOfCopies,
                      pageOrient: currentPdfModal!.pageOrient,
                      pagePrintSide: currentPdfModal!.pagePrintSide,
                      pageSize: currentPdfModal!.pageSize,
                      printJobType: currentPdfModal!.printJobType,
                      colorPagesRange: currentPdfModal!.colorPagesRange,
                      bindingType: value.toString(),
                      isBondPaperNeeded: currentPdfModal!.isBondPaperNeeded,
                      bondPaperRange: currentPdfModal!.bondPaperRange,
                      isTransparentSheetNeed:
                          currentPdfModal!.isTransparentSheetNeed,
                      transparentSheetColor:
                          currentPdfModal!.transparentSheetColor,
                      seletedShop: currentPdfModal!.seletedShop);
                  totalPrice = currentPdfModal!.getCostOfXerox();
                }),
              )),
            ),
          ),
          // const SizedBox(width: 20),
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
                Expanded(
                  flex: 4,
                  child: Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    child: const Center(
                      child: FittedBox(
                        child: Text(
                          "BondPaper :",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(28)),

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
                                currentPdfModal = PdfFiltersModal(
                                    pagesRange: currentPdfModal!.pagesRange,
                                    noOfCopies: currentPdfModal!.noOfCopies,
                                    pageOrient: currentPdfModal!.pageOrient,
                                    pagePrintSide:
                                        currentPdfModal!.pagePrintSide,
                                    pageSize: currentPdfModal!.pageSize,
                                    printJobType: currentPdfModal!.printJobType,
                                    colorPagesRange:
                                        currentPdfModal!.colorPagesRange,
                                    bindingType: currentPdfModal!.bindingType,
                                    isBondPaperNeeded: false,
                                    bondPaperRange: "",
                                    isTransparentSheetNeed:
                                        currentPdfModal!.isTransparentSheetNeed,
                                    transparentSheetColor:
                                        currentPdfModal!.transparentSheetColor,
                                    seletedShop: currentPdfModal!.seletedShop);
                                totalPrice = currentPdfModal!.getCostOfXerox();
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
                                  textAlign: TextAlign.center,
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
                                currentPdfModal = PdfFiltersModal(
                                    pagesRange: currentPdfModal!.pagesRange,
                                    noOfCopies: currentPdfModal!.noOfCopies,
                                    pageOrient: currentPdfModal!.pageOrient,
                                    pagePrintSide:
                                        currentPdfModal!.pagePrintSide,
                                    pageSize: currentPdfModal!.pageSize,
                                    printJobType: currentPdfModal!.printJobType,
                                    colorPagesRange:
                                        currentPdfModal!.colorPagesRange,
                                    bindingType: currentPdfModal!.bindingType,
                                    isBondPaperNeeded: true,
                                    bondPaperRange:_bondPagesController.text ,
                                    isTransparentSheetNeed:
                                        currentPdfModal!.isTransparentSheetNeed,
                                    transparentSheetColor:
                                        currentPdfModal!.transparentSheetColor,
                                    seletedShop: currentPdfModal!.seletedShop);
                                totalPrice = currentPdfModal!.getCostOfXerox();
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
                                  textAlign: TextAlign.center,
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
              ],
            ),
            showBondWingetSheetsTextBox == true
                ? AnimatedContainer(
                    padding: const EdgeInsets.only(top: 10),
                    height: BondPapersliderContHeight,
                    duration: const Duration(milliseconds: 300),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: const Center(
                                  child: FittedBox(
                                    child: Text(
                                      "Bond Pages :",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 40,
                                padding: const EdgeInsets.all(0),
                                child: TextField(
                                  onSubmitted: (value) {
                                    setState(() {
                                      currentPdfModal = PdfFiltersModal(
                                          pagesRange:
                                              currentPdfModal!.pagesRange,
                                          noOfCopies:
                                              currentPdfModal!.noOfCopies,
                                          pageOrient:
                                              currentPdfModal!.pageOrient,
                                          pagePrintSide:
                                              currentPdfModal!.pagePrintSide,
                                          pageSize: currentPdfModal!.pageSize,
                                          printJobType:
                                              currentPdfModal!.printJobType,
                                          colorPagesRange:
                                              _ColorPagesController.text,
                                          bindingType:
                                              currentPdfModal!.bindingType,
                                          isBondPaperNeeded: true,
                                          bondPaperRange:
                                              _bondPagesController.text,
                                          isTransparentSheetNeed:
                                              currentPdfModal!
                                                  .isTransparentSheetNeed,
                                          transparentSheetColor:
                                              currentPdfModal!
                                                  .transparentSheetColor,
                                          seletedShop:
                                              currentPdfModal!.seletedShop);
                                      totalPrice =
                                          currentPdfModal!.getCostOfXerox();
                                    });
                                  },
                                  cursorHeight: 25,
                                  controller: _bondPagesController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintStyle: TextStyle(fontSize: 18),
                                      hintText: "1-5,8"),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: InkWell(
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
                                child: Container(
                                  // padding: EdgeInsets.symmetric(
                                  //     horizontal: 10, vertical: 5),
                                  child: const Chip(
                                    label: Text(
                                      "Slider",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    backgroundColor: ColorPallets.deepBlue,
                                  ),
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
                                      const SizedBox(
                                        width: 10,
                                      ),
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
                                            onChanged: (value) {
                                              setState(
                                                () {
                                                  Bondvalues = value;
                                                  if (Bondvalues!.start ==
                                                      Bondvalues!.end) {
                                                    String tempString =
                                                        "${Bondvalues!.start.toInt()}";
                                                    _bondPagesController.text =
                                                        tempString;
                                                  } else {
                                                    String tempString =
                                                        "${Bondvalues!.start.toInt()}-${Bondvalues!.end.toInt()}";
                                                    _bondPagesController.text =
                                                        tempString;
                                                  }
                                                },
                                              );
                                              setState(() {
                                                currentPdfModal = PdfFiltersModal(
                                                    pagesRange: currentPdfModal!
                                                        .pagesRange,
                                                    noOfCopies: currentPdfModal!
                                                        .noOfCopies,
                                                    pageOrient: currentPdfModal!
                                                        .pageOrient,
                                                    pagePrintSide: currentPdfModal!
                                                        .pagePrintSide,
                                                    pageSize: currentPdfModal!
                                                        .pageSize,
                                                    printJobType:
                                                        currentPdfModal!
                                                            .printJobType,
                                                    colorPagesRange:
                                                        currentPdfModal!
                                                            .colorPagesRange,
                                                    bindingType:
                                                        currentPdfModal!
                                                            .bindingType,
                                                    isBondPaperNeeded: true,
                                                    bondPaperRange:
                                                        _bondPagesController
                                                            .text,
                                                    isTransparentSheetNeed:
                                                        currentPdfModal!
                                                            .isTransparentSheetNeed,
                                                    transparentSheetColor:
                                                        currentPdfModal!
                                                            .transparentSheetColor,
                                                    seletedShop:
                                                        currentPdfModal!
                                                            .seletedShop);
                                                totalPrice = currentPdfModal!
                                                    .getCostOfXerox();
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Text(
                                        totalPages.toString(),
                                        style: const TextStyle(
                                            fontSize: 22,
                                            color: ColorPallets.deepBlue),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
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
              Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  child: const Center(
                    child: FittedBox(
                      child: Text(
                        "Transparent\nSheet :",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  height: 40,
                  child: Row(children: [
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            needTransparent = false;
                            showTranparentSheetClour = false;
                            currentPdfModal = PdfFiltersModal(
                                pagesRange: currentPdfModal!.pagesRange,
                                noOfCopies: currentPdfModal!.noOfCopies,
                                pageOrient: currentPdfModal!.pageOrient,
                                pagePrintSide: currentPdfModal!.pagePrintSide,
                                pageSize: currentPdfModal!.pageSize,
                                printJobType: currentPdfModal!.printJobType,
                                colorPagesRange:
                                    currentPdfModal!.colorPagesRange,
                                bindingType: currentPdfModal!.bindingType,
                                isBondPaperNeeded:
                                    currentPdfModal!.isBondPaperNeeded,
                                bondPaperRange: currentPdfModal!.bondPaperRange,
                                isTransparentSheetNeed: false,
                                transparentSheetColor: "",
                                seletedShop: currentPdfModal!.seletedShop);
                            totalPrice = currentPdfModal!.getCostOfXerox();
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
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            needTransparent = true;
                          });
                          await Future.delayed(
                              const Duration(milliseconds: 300));
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
                              topRight: Radius.circular(22),
                              bottomRight: Radius.circular(22),
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
                  ]),
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            showTranparentSheetClour
                ? Container(
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              transpaperclr = TransparentPaperColor.blue;
                              currentPdfModal = PdfFiltersModal(
                                  pagesRange: currentPdfModal!.pagesRange,
                                  noOfCopies: currentPdfModal!.noOfCopies,
                                  pageOrient: currentPdfModal!.pageOrient,
                                  pagePrintSide: currentPdfModal!.pagePrintSide,
                                  pageSize: currentPdfModal!.pageSize,
                                  printJobType: currentPdfModal!.printJobType,
                                  colorPagesRange:
                                      currentPdfModal!.colorPagesRange,
                                  bindingType: currentPdfModal!.bindingType,
                                  isBondPaperNeeded:
                                      currentPdfModal!.isBondPaperNeeded,
                                  bondPaperRange:
                                      currentPdfModal!.bondPaperRange,
                                  isTransparentSheetNeed: true,
                                  transparentSheetColor: "Blue",
                                  seletedShop: currentPdfModal!.seletedShop);
                              totalPrice = currentPdfModal!.getCostOfXerox();
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
                                currentPdfModal = PdfFiltersModal(
                                    pagesRange: currentPdfModal!.pagesRange,
                                    noOfCopies: currentPdfModal!.noOfCopies,
                                    pageOrient: currentPdfModal!.pageOrient,
                                    pagePrintSide:
                                        currentPdfModal!.pagePrintSide,
                                    pageSize: currentPdfModal!.pageSize,
                                    printJobType: currentPdfModal!.printJobType,
                                    colorPagesRange:
                                        currentPdfModal!.colorPagesRange,
                                    bindingType: currentPdfModal!.bindingType,
                                    isBondPaperNeeded:
                                        currentPdfModal!.isBondPaperNeeded,
                                    bondPaperRange:
                                        currentPdfModal!.bondPaperRange,
                                    isTransparentSheetNeed: true,
                                    transparentSheetColor: "Green",
                                    seletedShop: currentPdfModal!.seletedShop);
                                totalPrice = currentPdfModal!.getCostOfXerox();
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
                              currentPdfModal = PdfFiltersModal(
                                  pagesRange: currentPdfModal!.pagesRange,
                                  noOfCopies: currentPdfModal!.noOfCopies,
                                  pageOrient: currentPdfModal!.pageOrient,
                                  pagePrintSide: currentPdfModal!.pagePrintSide,
                                  pageSize: currentPdfModal!.pageSize,
                                  printJobType: currentPdfModal!.printJobType,
                                  colorPagesRange:
                                      currentPdfModal!.colorPagesRange,
                                  bindingType: currentPdfModal!.bindingType,
                                  isBondPaperNeeded:
                                      currentPdfModal!.isBondPaperNeeded,
                                  bondPaperRange:
                                      currentPdfModal!.bondPaperRange,
                                  isTransparentSheetNeed: true,
                                  transparentSheetColor: "Brown",
                                  seletedShop: currentPdfModal!.seletedShop);
                              totalPrice = currentPdfModal!.getCostOfXerox();
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
                              currentPdfModal = PdfFiltersModal(
                                  pagesRange: currentPdfModal!.pagesRange,
                                  noOfCopies: currentPdfModal!.noOfCopies,
                                  pageOrient: currentPdfModal!.pageOrient,
                                  pagePrintSide: currentPdfModal!.pagePrintSide,
                                  pageSize: currentPdfModal!.pageSize,
                                  printJobType: currentPdfModal!.printJobType,
                                  colorPagesRange:
                                      currentPdfModal!.colorPagesRange,
                                  bindingType: currentPdfModal!.bindingType,
                                  isBondPaperNeeded:
                                      currentPdfModal!.isBondPaperNeeded,
                                  bondPaperRange:
                                      currentPdfModal!.bondPaperRange,
                                  isTransparentSheetNeed: true,
                                  transparentSheetColor: "purple",
                                  seletedShop: currentPdfModal!.seletedShop);
                              totalPrice = currentPdfModal!.getCostOfXerox();
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
                        ),
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
