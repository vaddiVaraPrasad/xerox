import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:xerox/Provider/current_user.dart';
import 'package:xerox/model/nearest_shops_model.dart';
import 'package:xerox/utils/color_pallets.dart';

import '../../../model/ListShopes.dart';
import '../../Global/api_keys.dart';
import '../../Provider/nearestShops.dart';
import '../../Provider/selected_shop.dart';
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
  Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(20.5937, 78.9629),
    zoom: 5,
  );
  final carouselCtrl = CarouselController();
  final lat_lng_index = {};

  Set<Marker> _markers = {};

  bool _isloading = false;
  final geo = GeoFlutterFire();
  final firestore = FirebaseFirestore.instance;
  bool isInitState = true;

  Future<void> goToSearchedPlace(double lat, double lag, double zoms) async {
    setState(() {
      _isloading = true;
    });
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lag),
          zoom: zoms,
          bearing: 80.0,
          tilt: 90,
        ),
      ),
    );
    setState(() {
      _isloading = false;
    });
  }

  void setMarkers(lat, lag) {
    setState(() {
      _isloading = true;
    });
    // _markers = {};
    final Marker marker = Marker(
      markerId: MarkerId("marker $lat $lag"),
      position: LatLng(lat, lag),
      onTap: () async {
        await goToSearchedPlace(lat, lag, 19);
        carouselCtrl.animateToPage(lat_lng_index["$lat $lag"]);
        // add the functin to turn the calostral list !!!
      },
      icon: BitmapDescriptor.defaultMarker,
      draggable: true,
      onDragEnd: (value) {
        print("on drag end values is ${value}");
      },
    );
    setState(() {
      _markers.add(marker);
    });
    setState(() {
      _isloading = false;
    });
  }

  Future<Map<String, String>> getTravelTimeAndDistance(
      String origin, double latitude, double longitude, String apiKey) async {
    var url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$latitude,$longitude&key=$apiKey';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 'OK') {
        Map<String, String> temp = {};
        temp["duration"] = data['routes'][0]['legs'][0]['duration']['text'];
        temp["distance"] = data['routes'][0]['legs'][0]['distance']['text'];
        return temp;
      }
    }
    return {};
  }

  void goToProviderLocation(CurrentUser curUser, double zoms) async {
    setState(() {
      _isloading = true;
    });
    await goToSearchedPlace(
        curUser.getUsetLatitude, curUser.getUserLongitude, zoms);
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
      int count_index = 0;
      CurrentUser curUser = Provider.of<CurrentUser>(context);
      NearestShopProvider nearshopprovider =
          Provider.of<NearestShopProvider>(context);

      GeoFirePoint center = geo.point(
          latitude: curUser.getUsetLatitude,
          longitude: curUser.getUserLongitude);
      var collectionReference = firestore.collection('shopUser');

      double radius = 20;
      String field = 'position';

      Stream<List<DocumentSnapshot>> stream = geo
          .collection(collectionRef: collectionReference)
          .within(center: center, radius: radius, field: field);

      stream.listen((List<DocumentSnapshot> documentList) {
        print("count shops!!");
        print(documentList.length);
        documentList.forEach((element) async {
          print("SHOPS !!!!!");
          var data = element.data() as Map<String, dynamic>;
          Map<String, String> DisDuration = await getTravelTimeAndDistance(
              "${curUser.getUsetLatitude},${curUser.getUserLongitude}",
              double.parse(data["shopDetails"]["shopLat"].toString()),
              double.parse(data["shopDetails"]["shopLng"].toString()),
              GlobalApiKeys.apiKeys);
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
              distanceFromCurrentLocation: DisDuration["distance"] as String,
              durationFromCurrentLocation: DisDuration["duration"] as String,
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
          setMarkers(double.parse(data["shopDetails"]["shopLat"].toString()),
              double.parse(data["shopDetails"]["shopLng"].toString()));
          lat_lng_index[
                  "${data["shopDetails"]["shopLat"]} ${data["shopDetails"]["shopLng"]}"] =
              count_index;
          setState(() {
            count_index = count_index + 1;
          });
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
    SelectedShop seletedShopProvider = Provider.of<SelectedShop>(context);
    CurrentUser curUSer = Provider.of<CurrentUser>(context);
    NearestShopProvider nearshopProvider =
        Provider.of<NearestShopProvider>(context);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            child: GoogleMap(
              initialCameraPosition: _initialCameraPosition,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                goToProviderLocation(curUSer, 16);
              },
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: true,
              compassEnabled: false,
              markers: _markers,
            ),
          ),
          Positioned(
            bottom: 20,
            child: Container(
              height: 160.0,
              width: screenWidth,
              child: CarouselSlider.builder(
                carouselController: carouselCtrl,
                options: CarouselOptions(
                  height: 150,
                  autoPlay: false,
                  reverse: false,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  initialPage: 0,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, reason) async {
                    await goToSearchedPlace(
                        nearshopProvider.getShopAtIndexLat(index),
                        nearshopProvider.getShopAtIndexLng(index),
                        19);
                  },
                ),
                itemCount: nearshopProvider.getShopListSize(),
                itemBuilder: (context, index, realIndex) {
                  return ShopContainer(nearshopProvider.getShopByIndex(index),
                      context, seletedShopProvider);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget ShopContainer(
      nearestShop shop, BuildContext ctx, SelectedShop seletedShopProvider) {
    return Container(
        height: 150,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          color: ColorPallets.deepBlue.withOpacity(.8),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    shop.shopName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 26),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Text(
                        shop.distanceFromCurrentLocation,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                      Expanded(
                          child: Text(shop.durationFromCurrentLocation,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18))),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () {
                      seletedShopProvider.setSeletedShop(shop);
                      Navigator.of(context).pushNamed(PdfFilters.routeName);
                    },
                    child: Container(
                      // margin:const  EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                      ),
                      height: 40,
                      child: const Text(
                        "Proceed",
                        style: TextStyle(
                          color: ColorPallets.deepBlue,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(right: 12, top: 15, bottom: 15),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    image: DecorationImage(
                        image: NetworkImage(shop.shopPicUrl),
                        fit: BoxFit.cover),
                  ),
                ))
          ],
        ));
  }
}
