import 'dart:io';

import 'package:flutter/material.dart';
import '../model/order_model.dart';

class CurrentOrder extends ChangeNotifier {
  Order currentOrder = Order(
    orderId: "",
    pdfFile: File(""),
    pdfName: "",
    priceOfOrder: "",
    pagesRange: "",
    noOfPages: "",
    noOfCopies: "",
    pageOrient: "",
    pagePrintSide: "",
    pageSize: "",
    printJobType: "",
    colorPagesCount: "",
    colorPagesRange: "",
    bindingType: "",
    isBondPaperNeeded: "",
    bondPaperRange: "",
    isTransparentSheetNeed: "",
    transparentSheetColor: "",
    customerId: "",
    customerName: "",
    customerEmailAddress: "",
    shopId: "",
    shopName: "",
    shopOweerName: "",
    shopEmail: "",
    shopDistanceFromCurrentLocation: "",
    durationFromCurrentLocation: "",
    shopAddress: "",
    dataOfOrder: "",
    orderStatus: "",
    modeOfOrder: "",
    shopPicUrl: "",
  );

  void setCurrentOrder(Order order) {
    currentOrder = order;
    notifyListeners();
  }

  Order getCurrentOrder() {
    return currentOrder;
  }

  void setFileAndFileName(File file, String fileName) {
    currentOrder.pdfFile = file;
    currentOrder.pdfName = fileName;
    notifyListeners();
  }

  File get getPdfFile {
    return currentOrder.pdfFile;
  }

  String get getPdfFileName {
    return currentOrder.pdfName;
  }

  void setPdfFilterDetails(
    String pagesRange,
    String noOfPages,
    String noOfCopies,
    String pageOrient,
    String pagePrintSide,
    String pageSize,
    String printJobType,
    String colorPagesRange,
    String colorPagesCount,
    String bindingType,
    String isBondPaperNeeded,
    String bondPaperRange,
    String isTransparentSheetNeed,
    String transparentSheetColor,
    String priceOfOrder,
  ) {
    currentOrder.pagesRange = pagesRange;
    currentOrder.noOfPages = noOfPages;
    currentOrder.noOfCopies = noOfCopies;
    currentOrder.pageOrient = pageOrient;
    currentOrder.pagePrintSide = pagePrintSide;
    currentOrder.pageSize = pageSize;
    currentOrder.printJobType = printJobType;
    currentOrder.colorPagesCount = colorPagesCount;
    currentOrder.colorPagesRange = colorPagesRange;
    currentOrder.bindingType = bindingType;
    currentOrder.isBondPaperNeeded = isBondPaperNeeded;
    currentOrder.bondPaperRange = bondPaperRange;
    currentOrder.isTransparentSheetNeed = isTransparentSheetNeed;
    currentOrder.transparentSheetColor = transparentSheetColor;
    currentOrder.priceOfOrder = priceOfOrder;
    notifyListeners();
  }

  String get orderPrice {
    return currentOrder.priceOfOrder;
  }

  String get orderNoOfPages {
    return currentOrder.noOfPages;
  }

  String get orderNoOfCoipies {
    return currentOrder.noOfCopies;
  }

  String get orderPagesOrient {
    return currentOrder.pageOrient;
  }

  String get orderPagesPrintSide {
    return currentOrder.pagePrintSide;
  }

  String get orderPageSize {
    return currentOrder.pageSize;
  }

  String get orderPrintJobType {
    return currentOrder.printJobType;
  }

  String get orderColorPagesRange {
    return currentOrder.colorPagesRange;
  }

  String get orderColorPagesCount {
    return currentOrder.colorPagesCount;
  }

  String get orderBindingType {
    return currentOrder.bindingType;
  }

  String get orderIsBOndPaperNeeded {
    return currentOrder.isBondPaperNeeded;
  }

  String get orderBondPapersRange {
    return currentOrder.bondPaperRange;
  }

  String get orderisTransparentSheetNeed {
    return currentOrder.isTransparentSheetNeed;
  }

  String get ordertransparentSheetColor {
    return currentOrder.transparentSheetColor;
  }

  void setCustomerInfo(
      String customerId, String customerName, String customerEmailAddress) {
    currentOrder.customerId = customerId;
    currentOrder.customerName = customerName;
    currentOrder.customerEmailAddress = customerEmailAddress;
    notifyListeners();
  }

  String get orderCustomerId {
    return currentOrder.customerId;
  }

  String get orderCustomerName {
    return currentOrder.customerName;
  }

  String get orderCustomerEmail {
    return currentOrder.customerEmailAddress;
  }

  void setShopDetails(
    String shopId,
    String shopName,
    String shopOwnerName,
    String shopEmail,
    String shopDistanceFromCurrentLocation,
    String durationFromCurrentLocation,
    String shopAddress,
    String shopPicUrl,
  ) {
    currentOrder.shopId = shopId;
    currentOrder.shopName = shopName;
    currentOrder.shopOweerName = shopOwnerName;
    currentOrder.shopEmail = shopEmail;
    currentOrder.shopDistanceFromCurrentLocation =
        shopDistanceFromCurrentLocation;
    currentOrder.durationFromCurrentLocation = durationFromCurrentLocation;
    currentOrder.shopAddress = shopAddress;
    currentOrder.shopPicUrl = shopPicUrl;
    notifyListeners();
  }

  String get orderShopOwnerName {
    return currentOrder.shopOweerName;
  }

  String get orderShopId {
    return currentOrder.shopId;
  }

  String get orderShopName {
    return currentOrder.shopName;
  }

  String get orderShopPicUrl {
    return currentOrder.shopPicUrl;
  }

  String get orderShopEmail {
    return currentOrder.shopEmail;
  }

  String get orderShopDistanceFromCurrentLocation {
    return currentOrder.shopDistanceFromCurrentLocation;
  }

  String get orderdurationFromCurrentLocation {
    return currentOrder.durationFromCurrentLocation;
  }

  String get orderShopAddress {
    return currentOrder.shopAddress;
  }

  void setOrderDetails(
    String orderId,
    String dateOfOrder,
    String orderStatus,
    String modeOfOrder,
  ) {
    currentOrder.orderId = orderId;
    currentOrder.dataOfOrder = dateOfOrder;
    currentOrder.orderStatus = orderStatus;
    currentOrder.modeOfOrder = modeOfOrder;
    notifyListeners();
  }

  void modifyOrderStatus(String status) {
    currentOrder.orderStatus = status;
    notifyListeners();
  }

  String get currentOrderId {
    return currentOrder.orderId;
  }

  String get currentOrderDateOfOrder {
    return currentOrder.dataOfOrder;
  }

  String get currentOrderStatus {
    return currentOrder.orderStatus;
  }

  String get currentOrderModeOfOrder {
    return currentOrder.modeOfOrder;
  }
}
