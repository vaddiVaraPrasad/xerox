import "dart:async";

import "package:flutter/material.dart";
import "package:geolocator/geolocator.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:provider/provider.dart";
import "package:xerox/Provider/current_user.dart";
import "package:xerox/utils/color_pallets.dart";

class setLocationMaps extends StatefulWidget {
  const setLocationMaps({super.key});
  static const routeName = "/setLocationMaps";
  @override
  State<setLocationMaps> createState() => _setLocationMapsState();
}

class _setLocationMapsState extends State<setLocationMaps> {
  Completer<GoogleMapController> _controller = Completer();

  int markerIdConter = 0;

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(20.5937, 78.9629),
    zoom: 5,
  );

  Set<Marker> _markers = {};

  Future<void> goToSearchedPlace(double lat, double lag, double zoms) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lag), zoom: zoms),
      ),
    );
  }

  void setMarkers(lat, lag) {
    _markers = {};
    var counter = markerIdConter++;
    final Marker marker = Marker(
      markerId: MarkerId("marker $counter"),
      position: LatLng(lat, lag),
      onTap: () async {
        await goToSearchedPlace(lat, lag, 16.5);
      },
      icon: BitmapDescriptor.defaultMarker,
    );
    setState(() {
      _markers.add(marker);
    });
  }

  void goToCurrentLocation(CurrentUser curUser, double zoms) async {
    double lat = curUser.getUsetLatitude;
    double lng = curUser.getUserLongitude;
    await goToSearchedPlace(lat, lng, zoms);
    setMarkers(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    CurrentUser curUser = Provider.of<CurrentUser>(context);
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: screenHeight,
                width: screenWidth,
                child: GoogleMap(
                  initialCameraPosition: _initialCameraPosition,
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    goToCurrentLocation(curUser, 17);
                  },
                  onCameraIdle: () {},
                  onCameraMove: (position) {},
                  // rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  markers: _markers,
                ),
              ),
              Positioned(
                  top: screenHeight - 250,
                  left: screenWidth / 4,
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorPallets.deepBlue.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: ColorPallets.deepBlue.withOpacity(1),
                            blurRadius: 5,
                          )
                        ]),
                    height: 50,
                    width: 190,
                  )),
              Positioned(
                top: screenHeight - 180,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorPallets.deepBlue.withOpacity(0.9),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ColorPallets.deepBlue.withOpacity(1),
                          blurRadius: 20,
                        )
                      ]),
                  height: 180,
                  width: screenWidth,
                  child: Column(
                    children: [
                      Expanded(flex: 4, child: Container()),
                      Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              color: ColorPallets.lightBlue,
                              child: const Center(
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
