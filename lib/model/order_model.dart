import 'dart:io';

class Order {
  File pdfFile;
  String pdfName;

  String priceOfOrder;

  String pagesRange;
  String noOfPages;
  String noOfCopies;
  String pageOrient;
  String pagePrintSide;
  String pageSize;
  String printJobType;
  String colorPagesRange;
  String colorPagesCount;
  String bindingType;
  String isBondPaperNeeded;
  String bondPaperRange;
  String isTransparentSheetNeed;
  String transparentSheetColor;

  String customerId;
  String customerName;
  String customerEmailAddress;

  String shopId;
  String shopName;
  String shopOweerName;
  String shopEmail;
  String shopDistanceFromCurrentLocation;
  String durationFromCurrentLocation;
  String shopAddress;
  String shopPicUrl;

  String orderId;
  String dataOfOrder;
  String orderStatus;
  String modeOfOrder;

  Order(
      {required this.orderId,
      required this.pdfFile,
      required this.pdfName,
      required this.priceOfOrder,
      required this.pagesRange,
      required this.noOfPages,
      required this.noOfCopies,
      required this.pageOrient,
      required this.pagePrintSide,
      required this.pageSize,
      required this.printJobType,
      required this.colorPagesCount,
      required this.colorPagesRange,
      required this.bindingType,
      required this.isBondPaperNeeded,
      required this.bondPaperRange,
      required this.isTransparentSheetNeed,
      required this.transparentSheetColor,
      required this.customerId,
      required this.customerName,
      required this.customerEmailAddress,
      required this.shopId,
      required this.shopName,
      required this.shopOweerName,
      required this.shopEmail,
      required this.shopDistanceFromCurrentLocation,
      required this.durationFromCurrentLocation,
      required this.shopAddress,
      required this.dataOfOrder,
      required this.orderStatus,
      required this.modeOfOrder,
      required this.shopPicUrl,
      });
}
