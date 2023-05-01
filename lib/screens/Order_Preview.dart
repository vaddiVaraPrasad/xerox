import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:xerox/Provider/current_user.dart';
import 'package:xerox/utils/color_pallets.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../Provider/current_order.dart';
import 'navBar_Screens/cart_Screen.dart';
import 'nav_drawers/navBar.dart';

class OrderPreviewScreen extends StatefulWidget {
  static const routeName = "/orderFilePreview";
  const OrderPreviewScreen({super.key});

  @override
  State<OrderPreviewScreen> createState() => _OrderPreviewScreenState();
}

class _OrderPreviewScreenState extends State<OrderPreviewScreen> {
  int seletedValue = 1;
  bool isUploadingToFirebase = false;

  String getCurrentDateTime() {
    final now = DateTime.now();
    final formatter = DateFormat('EEEE, MMMM d, yyyy - h:mm:ss a');
    final formatted = formatter.format(now);
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    CurrentOrder curOrder = Provider.of<CurrentOrder>(context);
    CurrentUser curUser = Provider.of<CurrentUser>(context);
    print(curOrder.orderIsBOndPaperNeeded == "true");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Preview!!"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: ListView(children: [
          const Text(
            "Document Details",
            style: TextStyle(
                color: ColorPallets.deepBlue,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          const Divider(color: ColorPallets.deepBlue, thickness: 2),
          KeyValueOfFeature("Pdf File Name", curOrder.getPdfFileName),
          KeyValueOfFeature("Price ", "Rs ${curOrder.orderPrice}"),
          KeyValueOfFeature("No of Copies", curOrder.orderNoOfCoipies),
          KeyValueOfFeature("Total No.of Pages",
              "${curOrder.orderNoOfCoipies} X ${curOrder.orderNoOfPages}"),
          KeyValueOfFeature("Page Orientation ", curOrder.orderPagesOrient),
          KeyValueOfFeature("Page Types", curOrder.orderPageSize),
          KeyValueOfFeature("Print Type", curOrder.orderPagesPrintSide),
          KeyValueOfFeature("Color ", curOrder.orderPrintJobType),
          curOrder.orderPrintJobType == "Partial Color"
              ? KeyValueOfFeature("Color Pages",
                  "${curOrder.orderColorPagesCount} (${curOrder.orderColorPagesRange})")
              : const SizedBox(),
          curOrder.orderBindingType != "NoBound"
              ? KeyValueOfFeature("Binding Type", curOrder.orderBindingType)
              : const SizedBox(),
          curOrder.orderIsBOndPaperNeeded == "true"
              ? KeyValueOfFeature("Bond Pages", curOrder.orderBondPapersRange)
              : const SizedBox(),
          curOrder.orderisTransparentSheetNeed == "true"
              ? KeyValueOfFeature(
                  "Transparent Color", curOrder.ordertransparentSheetColor)
              : const SizedBox(),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Shop Detials",
            style: TextStyle(
                color: ColorPallets.deepBlue,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          const Divider(color: ColorPallets.deepBlue, thickness: 2),
          KeyValueOfFeature("Shope Name", curOrder.orderShopName),
          KeyValueOfFeature("Owner Name", curOrder.orderShopOwnerName),
          KeyValueOfFeature("Shop Email", curOrder.orderShopEmail),
          KeyValueOfFeature(
              "Distance ", curOrder.orderShopDistanceFromCurrentLocation),
          KeyValueOfFeature(
              "Time taken", curOrder.orderdurationFromCurrentLocation),
          KeyValueOfFeature("Shop Address", curOrder.orderShopAddress),
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      "Rs ${curOrder.orderPrice}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20, color: ColorPallets.white),
                    ),
                  )),
            ),
            const SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  isUploadingToFirebase = true;
                });
                final pr = ProgressDialog(context: context);
                curOrder.setOrderDetails(Uuid().v4(), getCurrentDateTime(),
                    "Recevided", "CashOnDelivery");
                try {
                  pr.show(
                      max: 100,
                      progressType: ProgressType.valuable,
                      barrierColor:
                          Color.fromARGB(255, 183, 187, 187).withOpacity(.9),
                      msgColor: Colors.black,
                      msgFontSize: 18,
                      msgTextAlign: TextAlign.center,
                      progressBgColor: ColorPallets.deepBlue,
                      progressValueColor: Colors.white,
                      msg: "Sending your order to Shop");
                  final refPath = FirebaseStorage.instance
                      .ref()
                      .child("Orders")
                      .child(curOrder.orderCustomerId)
                      .child("XeroxDocuments")
                      .child(curOrder.currentOrderId);

                  await refPath
                      .putFile(curOrder.getPdfFile)
                      .whenComplete(() {});
                  String uploadedPdfUrl = await refPath.getDownloadURL();
                  print("PDf is  uploaded succesfully ");
                  print(uploadedPdfUrl);
                  await FirebaseFirestore.instance
                      .collection('Orders')
                      .doc(curOrder.currentOrderId)
                      .set({
                    "orderId": curOrder.currentOrderId,
                    "dateOfOrder": curOrder.currentOrderDateOfOrder,
                    "orderStatus": curOrder.currentOrderStatus,
                    "modeOfOrder": curOrder.currentOrderModeOfOrder,
                    "fileName": curOrder.getPdfFileName,
                    "fileUrlStorage": uploadedPdfUrl,
                    "priceOfOrder": curOrder.orderPrice,
                    "noOfPages": curOrder.orderNoOfPages,
                    "noOfCopies": curOrder.orderNoOfCoipies,
                    "pageOrient": curOrder.orderPagesOrient,
                    "pagePrintSide": curOrder.orderPagesPrintSide,
                    "pageSize": curOrder.orderPageSize,
                    "printJobType": curOrder.orderPrintJobType,
                    "colorPagesCount": curOrder.orderColorPagesCount,
                    "colorPagesRange": curOrder.orderColorPagesRange,
                    "bindingType": curOrder.orderBindingType,
                    "isBondPaperNeeded": curOrder.orderIsBOndPaperNeeded,
                    "bondPaperRange": curOrder.orderBondPapersRange,
                    "isTransparentSheetNeed":
                        curOrder.orderisTransparentSheetNeed,
                    "transparentSheetColor":
                        curOrder.ordertransparentSheetColor,
                    "customerId": curOrder.orderCustomerId,
                    "customerName": curOrder.orderCustomerName,
                    "customerEmailAddress": curOrder.orderCustomerEmail,
                    "customerProfileUrl": curUser.getUserProfileUrl,
                    "shopId": curOrder.orderShopId,
                    "shopName": curOrder.orderShopName,
                    "shopOwnerName": curOrder.orderShopOwnerName,
                    "shopEmail": curOrder.orderShopEmail,
                    "shopDistanceFromCurrentLocation":
                        curOrder.orderShopDistanceFromCurrentLocation,
                    "durationFromCurrentLocation":
                        curOrder.orderdurationFromCurrentLocation,
                    "shopAddress": curOrder.orderShopAddress,
                    "shopPicUrl": curOrder.orderShopPicUrl,
                  });
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Something went wrong !!"),
                        content: Text(e.toString()),
                        actions: [
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(
                              FontAwesomeIcons.check,
                              size: 30,
                            ),
                          )
                        ],
                      );
                    },
                  );
                } finally {
                  setState(() {
                    isUploadingToFirebase = false;
                    pr.close();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      ButtonNavigationBar.routeName,
                      (Route<dynamic> route) => route.isFirst,
                    );
                  });
                }
                // showModalBottomSheet(
                //   context: context,
                //   shape: const RoundedRectangleBorder(
                //     borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(20.0),
                //       topRight: Radius.circular(20.0),
                //     ),
                //   ),
                //   builder: (BuildContext context) {
                //     return Container(
                //       padding: const EdgeInsets.symmetric(
                //           vertical: 20, horizontal: 15),
                //       height: MediaQuery.of(context).size.height * .3,
                //       decoration: const BoxDecoration(
                //         borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(20.0),
                //           topRight: Radius.circular(20.0),
                //         ),
                //       ),
                //       child: Column(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           const Text(
                //             "Payment Options.",
                //             style: TextStyle(
                //                 color: ColorPallets.deepBlue,
                //                 fontSize: 22,
                //                 fontWeight: FontWeight.bold),
                //           ),
                //           const SizedBox(
                //             height: 5,
                //           ),
                //           const Divider(
                //               color: ColorPallets.deepBlue, thickness: 2),
                //           const SizedBox(
                //             height: 10,
                //           ),
                //           RadioListTile(
                //             value: 1,
                //             groupValue: seletedValue,
                //             onChanged: (value) {
                //               setState(() {
                //                 seletedValue = value!.toInt();
                //               });
                //               setState(() {});
                //             },
                //           ),
                //           const SizedBox(
                //             height: 5,
                //           ),

                //         ],
                //       ),
                //     );
                //   },
                // );
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
                          "Pay",
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
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget KeyValueOfFeature(String key, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 2),
      child: Row(
        children: [
          Expanded(
              child: Center(
            child: Text(
              key,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: ColorPallets.deepBlue),
              overflow: TextOverflow.ellipsis,
            ),
          )),
          const SizedBox(
            width: 10,
          ),
          const Text(
            ":",
            style: TextStyle(
              fontSize: 18,
              color: ColorPallets.deepBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Center(
            child: Text(
              value,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.black54),
              overflow: TextOverflow.ellipsis,
            ),
          )),
        ],
      ),
    );
  }
}
