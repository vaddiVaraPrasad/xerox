import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xerox/Provider/current_user.dart';
import 'package:xerox/utils/color_pallets.dart';

import '../../../model/ListShopes.dart';
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
  // GeoFirestore geoFirestore =
  //     GeoFirestore(FirebaseFirestore.instance.collection('nearShops'));

  // when ever when user select anyshop it has to that that shop id and file to filters page
  void fetchNearestShopGeoFire(CurrentUser curUser) async {
    setState(() {
      _isloading = true;
    });
    final queryLocation =
        GeoPoint(curUser.getUsetLatitude, curUser.getUserLongitude);
    // final List<DocumentSnapshot> documents =
        // await geoFirestore.getAtLocation(queryLocation, 100000);
    print("data is fetched");
    print(curUser.getUsetLatitude);
    print(curUser.getUserLongitude);
    // print(documents.length);
    // documents.forEach((document) {
      // print(document.data);
    // });
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    File file = ModalRoute.of(context)!.settings.arguments as File;
    CurrentUser curUSer = Provider.of<CurrentUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("select shop !!!"),
      ),
      body: Center(
          child: _isloading
              ? const CircularProgressIndicator(
                  color: ColorPallets.deepBlue,
                )
              : ElevatedButton(
                  onPressed: () {
                    fetchNearestShopGeoFire(curUSer);
                  },
                  child: const Text("pres to get nearest shops "))),
    );
  }
}
