import 'dart:ffi';

import "../screens/pdf/pdf_filters_Screen.dart";
import "./pdf_shop_cost.dart";

class PdfFiltersModal {
  final String pagesRange;
  final String noOfCopies;
  final PageOrientation pageOrient;

  final PritingSides pagePrintSide;
  final String pageSize;
  final JobTypes printJobType;
  final String colorPagesRange;

  final String bindingType;
  final bool isBondPaperNeeded;
  final String bondPaperRange;
  final bool isTransparentSheetNeed;
  final String transparentSheetColor;
  final PdShopeCost seletedShop;

  PdfFiltersModal(
      {required this.pagesRange,
      required this.noOfCopies,
      required this.pageOrient,
      required this.pagePrintSide,
      required this.pageSize,
      required this.printJobType,
      required this.colorPagesRange,
      required this.bindingType,
      required this.isBondPaperNeeded,
      required this.bondPaperRange,
      required this.isTransparentSheetNeed,
      required this.transparentSheetColor,
      required this.seletedShop});

  static int getPagesCount(String strRange) {
    int count = 0;
    // print("strRange is $strRange");
    if (strRange.isNotEmpty) {
      final list = strRange.split(',');
      // print("list is $list");
      for (int i = 0; i < list.length; i++) {
        if (list[i].contains('-')) {
          final innerList = list[i].split('-');
          // print("inner list is $innerList");
          var tempcount = int.parse(innerList[1]) - int.parse(innerList[0]) + 1;
          count += tempcount;
          // print("cont is $count");
        } else {
          count += 1;
        }
      }
    }

    // print("strRange is $strRange and count is $count");
    return count;
  }

  double getCostOfXerox() {
    double totalCost = 0;
    int noOfColorPages = 0;
    int noOfPagesBoundPaper = 0;

    int noOfPages = getPagesCount(pagesRange);
    if (printJobType != JobTypes.blackAndWhite) {
      noOfColorPages = getPagesCount(colorPagesRange as String);
      // print("no of coloe pages are $noOfColorPages");
    }
    if (isBondPaperNeeded) {
      noOfPagesBoundPaper = getPagesCount(bondPaperRange as String);
    }

    if (pageSize == "A0") {
      if (pagePrintSide == PritingSides.singleSided) {
        totalCost += noOfPages * seletedShop.costForA0PerSingleSide;
      }
      if (pagePrintSide == PritingSides.doubleSided) {
        totalCost = noOfPages * seletedShop.costForA0PErDobuleSide;
      }
      if (printJobType == JobTypes.fullColor) {
        totalCost += noOfPages * seletedShop.costOfColorPerPageForA0;
      }
      if (printJobType == JobTypes.partialColor) {
        totalCost += noOfColorPages * seletedShop.costOfColorPerPageForA0;
      }
    }
    if (pageSize == "A1") {
      if (pagePrintSide == PritingSides.singleSided) {
        totalCost = noOfPages * seletedShop.costForA1PerSingleSide;
      }
      if (pagePrintSide == PritingSides.doubleSided) {
        totalCost = noOfPages * seletedShop.costForA1PErDobuleSide;
      }
      if (printJobType == JobTypes.fullColor) {
        totalCost += noOfPages * seletedShop.costOfColorPerPageForA1;
      }
      if (printJobType == JobTypes.partialColor) {
        totalCost += noOfColorPages * seletedShop.costOfColorPerPageForA1;
      }
    }
    if (pageSize == "A2") {
      if (pagePrintSide == PritingSides.singleSided) {
        totalCost = noOfPages * seletedShop.costForA2PerSingleSide;
      }
      if (pagePrintSide == PritingSides.doubleSided) {
        totalCost = noOfPages * seletedShop.costForA2PErDobuleSide;
      }
      if (printJobType == JobTypes.fullColor) {
        totalCost += noOfPages * seletedShop.costOfColorPerPageForA2;
      }
      if (printJobType == JobTypes.partialColor) {
        totalCost += noOfColorPages * seletedShop.costOfColorPerPageForA2;
      }
    }
    if (pageSize == "A3") {
      if (pagePrintSide == PritingSides.singleSided) {
        totalCost = noOfPages * seletedShop.costForA3PerSingleSide;
      }
      if (pagePrintSide == PritingSides.doubleSided) {
        totalCost = noOfPages * seletedShop.costForA3PErDobuleSide;
      }
      if (printJobType == JobTypes.fullColor) {
        totalCost += noOfPages * seletedShop.costOfColorPerPageForA3;
      }
      if (printJobType == JobTypes.partialColor) {
        totalCost += noOfColorPages * seletedShop.costOfColorPerPageForA3;
      }
    }
    if (pageSize == "A4") {
      if (pagePrintSide == PritingSides.singleSided) {
        totalCost = noOfPages * seletedShop.costForA4PerSingleSide;
      }
      if (pagePrintSide == PritingSides.doubleSided) {
        totalCost = noOfPages * seletedShop.costForA4PErDobuleSide;
      }
      if (printJobType == JobTypes.fullColor) {
        totalCost += noOfPages * seletedShop.costOfColorPerPageForA4;
      }
      if (printJobType == JobTypes.partialColor) {
        totalCost += noOfColorPages * seletedShop.costOfColorPerPageForA4;
      }
    }
    if (pageSize == "A5") {
      if (pagePrintSide == PritingSides.singleSided) {
        totalCost = noOfPages * seletedShop.costForA5PerSingleSide;
      }
      if (pagePrintSide == PritingSides.doubleSided) {
        totalCost = noOfPages * seletedShop.costForA5PErDobuleSide;
      }
      if (printJobType == JobTypes.fullColor) {
        totalCost += noOfPages * seletedShop.costOfColorPerPageForA5;
      }
      if (printJobType == JobTypes.partialColor) {
        totalCost += noOfColorPages * seletedShop.costOfColorPerPageForA5;
      }
    }
    if (pageSize == "Legal") {
      if (pagePrintSide == PritingSides.singleSided) {
        totalCost = noOfPages * seletedShop.costForLegalPerSingleSide;
      }
      if (pagePrintSide == PritingSides.doubleSided) {
        totalCost = noOfPages * seletedShop.costForLegalPErDobuleSide;
      }
      if (printJobType == JobTypes.fullColor) {
        totalCost += noOfPages * seletedShop.costOfColorPerPageForLegal;
      }
      if (printJobType == JobTypes.partialColor) {
        totalCost += noOfColorPages * seletedShop.costOfColorPerPageForLegal;
      }
    }
    if (pageSize == "Letter") {
      if (pagePrintSide == PritingSides.singleSided) {
        totalCost = noOfPages * seletedShop.costForLetterPerSingleSide;
      }
      if (pagePrintSide == PritingSides.doubleSided) {
        totalCost = noOfPages * seletedShop.costForLegalPErDobuleSide;
      }
      if (printJobType == JobTypes.fullColor) {
        totalCost += noOfPages * seletedShop.costOfColorPerPageForLetter;
      }
      if (printJobType == JobTypes.partialColor) {
        totalCost += noOfColorPages * seletedShop.costOfColorPerPageForLetter;
      }
    }
    if (bindingType == "HardBound") {
      totalCost += seletedShop.costForHardBound;
    }
    if (bindingType == "SpiralBound") {
      totalCost += seletedShop.costForSpiralBound;
    }

    if (bindingType == "StickFile") {
      totalCost += seletedShop.costForStickFile;
    }

    if (isBondPaperNeeded) {
      totalCost +=
          noOfPagesBoundPaper * seletedShop.costForOneBondPaper.toInt();
    }

    if (isTransparentSheetNeed) {
      totalCost += seletedShop.costForTransparentSheetPerSheet;
    }

    print("total cost is $totalCost");

    if (noOfCopies.isNotEmpty) {
      totalCost *= int.parse(noOfCopies);
    }

    return totalCost.toDouble();
  }
}
