import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xerox/Provider/current_user.dart';
import 'package:xerox/model/nearest_shops_model.dart';
import 'package:xerox/utils/color_pallets.dart';

import '../../../model/ListShopes.dart';
import '../../Provider/nearestShops.dart';
import 'pdf_filters_Screen.dart';

class DummyShops extends StatefulWidget {
  static const routeName = "/dummyShopes";

  const DummyShops({
    super.key,
  });

  @override
  State<DummyShops> createState() => _DummyShopsState();
}

class _DummyShopsState extends State<DummyShops> {
  bool _isloading = false;
  final geo = GeoFlutterFire();
  final firestore = FirebaseFirestore.instance;
  bool isInitState = true;

  void fetchNearestShopGeoFire(
      CurrentUser curUser, NearestShopProvider nearshopprovider) async {
    setState(() {
      _isloading = true;
    });
    GeoFirePoint center = geo.point(
        latitude: curUser.getUsetLatitude, longitude: curUser.getUserLongitude);
    var collectionReference = firestore.collection('shopUser');

    double radius = 20;
    String field = 'position';

    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: collectionReference)
        .within(center: center, radius: radius, field: field);

    stream.listen((List<DocumentSnapshot> documentList) {
      print("count shops!!");
      print(documentList.length);
      documentList.forEach((element) {
        print("SHOPS !!!!!");
        var data = element.data() as Map<String, dynamic>;
        nearestShop shop = nearestShop(
            email: data["email"],
            ownerProfilePicUrl: data["profilePicUrl"],
            shopAddress: data["shopDetails"]["shopAdress"],
            shopLatitude:
                double.parse(data["shopDetails"]["shopLat"].toString()),
            shopLongitude:
                double.parse(data["shopDetails"]["shopLng"].toString()),
            shopName: data["shopDetails"]["shopName"],
            shopOwnerName: data["shopDetails"]["shopOwnerName"],
            shopPicUrl: data["shopDetails"]["shopPicUrl"],
            shopID: data["userId"],
            shopCityName: data["shopDetails"]["cityName"],
            costForA0PerSingleSide: double.parse(
                data["shopPrices"]["costForA0PerSingleSide"].toString()),
            costForA0PErDobuleSide: double.parse(
                data["shopPrices"]["costForA0PErDobuleSide"].toString()),
            costForA1PErDobuleSide: double.parse(
                data["shopPrices"]["costForA1PErDobuleSide"].toString()),
            costForA1PerSingleSide: double.parse(
                data["shopPrices"]["costForA1PerSingleSide"].toString()),
            costForA2PErDobuleSide: double.parse(
                data["shopPrices"]["costForA2PErDobuleSide"].toString()),
            costForA2PerSingleSide: double.parse(
                data["shopPrices"]["costForA2PerSingleSide"].toString()),
            costForA3PErDobuleSide: double.parse(
                data["shopPrices"]["costForA3PErDobuleSide"].toString()),
            costForA3PerSingleSide: double.parse(
                data["shopPrices"]["costForA3PerSingleSide"].toString()),
            costForA4PErDobuleSide:
                double.parse(data["shopPrices"]["costForA4PErDobuleSide"].toString()),
            costForA4PerSingleSide: double.parse(data["shopPrices"]["costForA4PerSingleSide"].toString()),
            costForA5PErDobuleSide: double.parse(data["shopPrices"]["costForA5PErDobuleSide"].toString()),
            costForA5PerSingleSide: double.parse(data["shopPrices"]["costForA5PerSingleSide"].toString()),
            costForLegalPErDobuleSide: double.parse(data["shopPrices"]["costForLegalPErDobuleSide"].toString()),
            costForLegalPerSingleSide: double.parse(data["shopPrices"]["costForLegalPerSingleSide"].toString()),
            costForLetterPErDobuleSide: double.parse(data["shopPrices"]["costForLetterPErDobuleSide"].toString()),
            costForLetterPerSingleSide: double.parse(data["shopPrices"]["costForLetterPerSingleSide"].toString()),
            costOfColorPerPageForA0: double.parse(data["shopPrices"]["costOfColorPerPageForA0"].toString()),
            costOfColorPerPageForA1: double.parse(data["shopPrices"]["costOfColorPerPageForA1"].toString()),
            costOfColorPerPageForA2: double.parse(data["shopPrices"]["costOfColorPerPageForA2"].toString()),
            costOfColorPerPageForA3: double.parse(data["shopPrices"]["costOfColorPerPageForA3"].toString()),
            costOfColorPerPageForA4: double.parse(data["shopPrices"]["costOfColorPerPageForA4"].toString()),
            costOfColorPerPageForA5: double.parse(data["shopPrices"]["costOfColorPerPageForA5"].toString()),
            costOfColorPerPageForLegal: double.parse(data["shopPrices"]["costOfColorPerPageForLegal"].toString()),
            costOfColorPerPageForLetter: double.parse(data["shopPrices"]["costOfColorPerPageForLetter"].toString()),
            costForHardBound: double.parse(data["shopPrices"]["costForHardBound"].toString()),
            costForSpiralBound: double.parse(data["shopPrices"]["costForSpiralBound"].toString()),
            costForStickFile: double.parse(data["shopPrices"]["costForStickFile"].toString()),
            costForOneBondPaper: double.parse(data["shopPrices"]["costForOneBondPaper"].toString()),
            costForTransparentSheetPerSheet: double.parse(data["shopPrices"]["costForTransparentSheetPerSheet"].toString()));
        nearshopprovider.addShopToList(shop);
      });
    });

    setState(() {
      _isloading = false;
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (isInitState) {
      setState(() {
      _isloading = true;
    });
    CurrentUser curUser = Provider.of<CurrentUser>(context);
    NearestShopProvider nearshopprovider =
        Provider.of<NearestShopProvider>(context);

    GeoFirePoint center = geo.point(
        latitude: curUser.getUsetLatitude, longitude: curUser.getUserLongitude);
    var collectionReference = firestore.collection('shopUser');

    double radius = 20;
    String field = 'position';

    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: collectionReference)
        .within(center: center, radius: radius, field: field);

    stream.listen((List<DocumentSnapshot> documentList) {
      print("count shops!!");
      print(documentList.length);
      documentList.forEach((element) {
        print("SHOPS !!!!!");
        var data = element.data() as Map<String, dynamic>;
        nearestShop shop = nearestShop(
            email: data["email"],
            ownerProfilePicUrl: data["profilePicUrl"],
            shopAddress: data["shopDetails"]["shopAdress"],
            shopLatitude:
                double.parse(data["shopDetails"]["shopLat"].toString()),
            shopLongitude:
                double.parse(data["shopDetails"]["shopLng"].toString()),
            shopName: data["shopDetails"]["shopName"],
            shopOwnerName: data["shopDetails"]["shopOwnerName"],
            shopPicUrl: data["shopDetails"]["shopPicUrl"],
            shopID: data["userId"],
            shopCityName: data["shopDetails"]["cityName"],
            costForA0PerSingleSide: double.parse(
                data["shopPrices"]["costForA0PerSingleSide"].toString()),
            costForA0PErDobuleSide: double.parse(
                data["shopPrices"]["costForA0PErDobuleSide"].toString()),
            costForA1PErDobuleSide: double.parse(
                data["shopPrices"]["costForA1PErDobuleSide"].toString()),
            costForA1PerSingleSide: double.parse(
                data["shopPrices"]["costForA1PerSingleSide"].toString()),
            costForA2PErDobuleSide: double.parse(
                data["shopPrices"]["costForA2PErDobuleSide"].toString()),
            costForA2PerSingleSide: double.parse(
                data["shopPrices"]["costForA2PerSingleSide"].toString()),
            costForA3PErDobuleSide: double.parse(
                data["shopPrices"]["costForA3PErDobuleSide"].toString()),
            costForA3PerSingleSide: double.parse(
                data["shopPrices"]["costForA3PerSingleSide"].toString()),
            costForA4PErDobuleSide:
                double.parse(data["shopPrices"]["costForA4PErDobuleSide"].toString()),
            costForA4PerSingleSide: double.parse(data["shopPrices"]["costForA4PerSingleSide"].toString()),
            costForA5PErDobuleSide: double.parse(data["shopPrices"]["costForA5PErDobuleSide"].toString()),
            costForA5PerSingleSide: double.parse(data["shopPrices"]["costForA5PerSingleSide"].toString()),
            costForLegalPErDobuleSide: double.parse(data["shopPrices"]["costForLegalPErDobuleSide"].toString()),
            costForLegalPerSingleSide: double.parse(data["shopPrices"]["costForLegalPerSingleSide"].toString()),
            costForLetterPErDobuleSide: double.parse(data["shopPrices"]["costForLetterPErDobuleSide"].toString()),
            costForLetterPerSingleSide: double.parse(data["shopPrices"]["costForLetterPerSingleSide"].toString()),
            costOfColorPerPageForA0: double.parse(data["shopPrices"]["costOfColorPerPageForA0"].toString()),
            costOfColorPerPageForA1: double.parse(data["shopPrices"]["costOfColorPerPageForA1"].toString()),
            costOfColorPerPageForA2: double.parse(data["shopPrices"]["costOfColorPerPageForA2"].toString()),
            costOfColorPerPageForA3: double.parse(data["shopPrices"]["costOfColorPerPageForA3"].toString()),
            costOfColorPerPageForA4: double.parse(data["shopPrices"]["costOfColorPerPageForA4"].toString()),
            costOfColorPerPageForA5: double.parse(data["shopPrices"]["costOfColorPerPageForA5"].toString()),
            costOfColorPerPageForLegal: double.parse(data["shopPrices"]["costOfColorPerPageForLegal"].toString()),
            costOfColorPerPageForLetter: double.parse(data["shopPrices"]["costOfColorPerPageForLetter"].toString()),
            costForHardBound: double.parse(data["shopPrices"]["costForHardBound"].toString()),
            costForSpiralBound: double.parse(data["shopPrices"]["costForSpiralBound"].toString()),
            costForStickFile: double.parse(data["shopPrices"]["costForStickFile"].toString()),
            costForOneBondPaper: double.parse(data["shopPrices"]["costForOneBondPaper"].toString()),
            costForTransparentSheetPerSheet: double.parse(data["shopPrices"]["costForTransparentSheetPerSheet"].toString()));
        nearshopprovider.addShopToList(shop);
      });
    });

    setState(() {
      _isloading = false;
    });
    }
    setState(() {
      isInitState = false;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    File file = ModalRoute.of(context)!.settings.arguments as File;
    CurrentUser curUSer = Provider.of<CurrentUser>(context);
    NearestShopProvider nearshopProvider =
        Provider.of<NearestShopProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("select shop !!!"),
      ),
      body: _isloading
          ? const CircularProgressIndicator(
              color: ColorPallets.deepBlue,
            )
          : Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      print(nearshopProvider.getShopListSize());
                    },
                    child: const Text("detials abt nearShop list "))
              ],
            ),
    );
  }
}
