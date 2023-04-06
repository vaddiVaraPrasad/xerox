import "dart:async";

import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:geolocator/geolocator.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:provider/provider.dart";
import "package:xerox/Provider/current_user.dart";
import "package:xerox/screens/maps/textLocation.dart";
import "package:xerox/utils/color_pallets.dart";

import "../../helpers/user_location.dart";
import "../../widgets/IconButton.dart";

class setLocationMaps extends StatefulWidget {
  const setLocationMaps({super.key});
  static const routeName = "/setLocationMaps";
  @override
  State<setLocationMaps> createState() => _setLocationMapsState();
}

class _setLocationMapsState extends State<setLocationMaps> {
  Completer<GoogleMapController> _controller = Completer();

  BitmapDescriptor? mapMaker;

  bool isLoading = false;

  @override
  void initState() {
    setCustomMarker();
    super.initState();
  }

  void setCustomMarker() async {
    mapMaker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/image/pin_gif.gif");
  }

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
    final Marker marker = Marker(
      markerId: MarkerId("marker $lat $lag"),
      position: LatLng(lat, lag),
      onTap: () async {
        await goToSearchedPlace(lat, lag, 16.5);
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
  }

  void goToProviderLocation(CurrentUser curUser, double zoms) async {
    await goToSearchedPlace(
        curUser.getUsetLatitude, curUser.getUserLongitude, zoms);
    setMarkers(curUser.getUsetLatitude, curUser.getUserLongitude);
  }

  void updateOnTapLocation(
      CurrentUser curUser, LatLng location, double zooms) async {
    Map<String, dynamic> userPlaceMark = await UserLocation.getUserPlaceMarks(
        location.latitude, location.longitude);
    await goToSearchedPlace(location.latitude, location.longitude, zooms);
    setMarkers(location.latitude, location.longitude);
    curUser.setUserLatitudeLogitude(location.latitude, location.longitude);
    curUser.setUserPlaceName(userPlaceMark["locality"]);
    curUser.setUserContryName(userPlaceMark["country"]);
  }

  void goToCurrentLocation(CurrentUser curUser, double zoms) async {
    Position userCurrentPosition = await UserLocation.getUserLatLong();
    Map<String, dynamic> userPlaceMark = await UserLocation.getUserPlaceMarks(
        userCurrentPosition.latitude, userCurrentPosition.longitude);
    await goToSearchedPlace(
        userCurrentPosition.latitude, userCurrentPosition.longitude, zoms);
    setMarkers(userCurrentPosition.latitude, userCurrentPosition.longitude);
    curUser.setUserLatitudeLogitude(
        userCurrentPosition.latitude, userCurrentPosition.longitude);
    curUser.setUserPlaceName(userPlaceMark["locality"]);
    curUser.setUserContryName(userPlaceMark["country"]);
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
                    setState(() {
                      isLoading = true;
                    });
                    _controller.complete(controller);
                    goToProviderLocation(curUser, 16);
                    setState(() {
                      isLoading = false;
                    });
                  },
                  // onCameraIdle: () {},
                  // onCameraMove: (position) {},
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  onTap: (val) {
                    setState(() {
                      isLoading = true;
                    });
                    updateOnTapLocation(curUser, val, 18);
                    setState(() {
                      isLoading = false;
                    });
                  },

                  markers: _markers,
                ),
              ),
              Positioned(
                top: screenHeight - 250,
                left: screenWidth / 4,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isLoading = true;
                    });
                    goToCurrentLocation(curUser, 18);
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 8, left: 15, bottom: 8),
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
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/image/current_loaction.png",
                          fit: BoxFit.cover,
                          color: Colors.white,
                          height: 35,
                          width: 35,
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        const Text(
                          "Current Location",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        )
                      ],
                    ),
                  ),
                ),
              ),
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
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                width: screenWidth - 20,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 30),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          curUser.getPlaceName,
                                          style: const TextStyle(
                                            overflow: TextOverflow.fade,
                                            color: Colors.white,
                                            fontSize: 27,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                LocationText.routeName);
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 110,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 2,
                                                style: BorderStyle.solid,
                                              ),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Change",
                                                style: TextStyle(
                                                    overflow: TextOverflow.clip,
                                                    color: Colors.white,
                                                    fontSize: 18),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "${curUser.getPlaceName}, ${curUser.getUserContryName}}",
                                            style: const TextStyle(
                                              overflow: TextOverflow.fade,
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    print(curUser.getPlaceName);
                                    print(curUser.getUserContryName);
                                    Navigator.of(context).pop();
                                  },
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
              ),
              Positioned(
                  left: 30,
                  top: 50,
                  child: CustomIconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: FontAwesomeIcons.chevronLeft,
                    iconColor: ColorPallets.white,
                    backGroundColor: ColorPallets.deepBlue,
                    size: 40,
                    iconSize: 16,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
