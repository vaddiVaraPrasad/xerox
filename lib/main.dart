// import "package:connectivity_plus/connectivity_plus.dart";
// import "package:firebase_auth/firebase_auth.dart";
// import 'package:flutter/material.dart';
// import "package:firebase_core/firebase_core.dart";
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:xerox/firebase_options.dart';
// import "package:xerox/helpers/sqlLite.dart";
// import "package:xerox/screens/additional/network_error.dart";
// import "package:xerox/screens/auth/auth_screen.dart";
// import "package:xerox/screens/maps/textLocation.dart";
// import "package:xerox/screens/nav_drawers/hidden_drawer.dart";
// import 'package:xerox/screens/notificationPage.dart';
// import 'package:xerox/screens/pdf/cutom_pdf_Render_Screen.dart';
// import "package:provider/provider.dart";

// import "./utils/color_pallets.dart";

// import "./screens/auth/forget_password_Screen.dart";
// import "./screens/nav_drawers/navBar.dart";

// import "Provider/search_place.dart";
// import 'screens/dummy_screen.dart';
// import 'screens/pdf/dummyshopsScreen.dart';
// import 'screens/navBar_Screens/cart_Screen.dart';
// import "screens/drawer_Screens/ContactUs.dart";
// import "screens/navBar_Screens/home_screen.dart";
// import "screens/drawer_Screens/about_us_Screen.dart";
// import "screens/navBar_Screens/profile_Screen.dart";
// import "screens/drawer_Screens/orders_Screen.dart";
// import "screens/drawer_Screens/rewards_screen.dart";
// import "screens/navBar_Screens/search_shop_screen.dart";
// import "screens/pdf/images_grid_file.dart";
// import "screens/pdf/pdf_filters_Screen.dart";
// import "screens/maps/setLocationMaps.dart";

// import "./Provider/current_user.dart";

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   SQLHelpers.getDatabase;

//   runApp(Xerox());
// }

// class Xerox extends StatefulWidget {
//   Xerox({super.key});

//   @override
//   State<Xerox> createState() => _XeroxState();
// }

// class _XeroxState extends State<Xerox> {
//   final Stream<ConnectivityResult> connectivityStream =
//       Connectivity().onConnectivityChanged;

//   final Stream<User?> authStateChanges =
//       FirebaseAuth.instance.authStateChanges();



//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) => CurrentUser(),
//         ),
//         ChangeNotifierProvider(
//           create: (context) => PlaceResult(),
//         ),
//       ],
//       child: MaterialApp(
//         title: "Xerox",
//         debugShowCheckedModeBanner: false,
//         // googlefonts.istokweb is for heading  .. when ever in need use there ..
//         // googlefonts.lora is for body ..... so we defing the lora as global text theme
//         theme: ThemeData(
//           // canvasColor: ColorPallets.yellowShadedPurple,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//           textTheme: GoogleFonts.ubuntuTextTheme(),
//           colorScheme: ColorScheme.fromSwatch().copyWith(
//             secondary: ColorPallets.pinkinshShadedPurple,
//             primary: ColorPallets.deepBlue,
//           ),
//           appBarTheme: const AppBarTheme(
//               color: ColorPallets.deepBlue,
//               systemOverlayStyle: SystemUiOverlayStyle.light),
//         ),
//         home: StreamBuilder<ConnectivityResult>(
//             stream: Connectivity().onConnectivityChanged,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 switch (snapshot.data!) {
//                   case ConnectivityResult.wifi:
//                   case ConnectivityResult.mobile:
//                     return StreamBuilder<User?>(
//                       stream: FirebaseAuth.instance.authStateChanges(),
//                       builder: (context, snapshot) {
//                         if (snapshot.hasData) {
//                           return const HiddenSideZoomDrawer();
//                         } else if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const CircularProgressIndicator();
//                         } else {
//                           return const AuthScreen();
//                         }
//                       },
//                     );
//                   default:
//                     return const NetworkError();
//                 }
//               } else {
//                 return const CircularProgressIndicator();
//               }
//             }),
//         routes: {
//           ForgetPasswordScreen.routeName: (context) =>
//               const ForgetPasswordScreen(),
//           AboutUs.routeName: (context) => const AboutDialog(),
//           CartScreen.routeName: (context) => const CartScreen(),
//           ContactUs.routeName: (context) => const ContactUs(),
//           HomeScreen.routeName: (context) => const HomeScreen(),
//           OrderScreen.routeName: (context) => const OrderScreen(),
//           ProfilePage.routeName: (context) => const ProfilePage(),
//           rewardsScreen.routeName: (context) => const rewardsScreen(),
//           SearchShop.routeName: (context) => const SearchShop(),
//           DummyScreen.routeName: (context) => const DummyScreen(),
//           CustomPDFPreview.routeName: (context) => const CustomPDFPreview(),
//           PdfImagesRender.routeName: (context) => const PdfImagesRender(),
//           PdfFilters.routeName: (context) => const PdfFilters(),
//           NotificationPage.routeName: (context) => const NotificationPage(),
//           DummyShops.routeName: (context) => const DummyShops(),
//           ButtonNavigationBar.routeName: (context) =>
//               const ButtonNavigationBar(),
//           setLocationMaps.routeName: (context) => const setLocationMaps(),
//           LocationText.routeName : (context) => const LocationText(),
//           // HiddenSideZoomDrawer.routeName: (context) => const HiddenSideZoomDrawer()
//         },
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Geo Flutter Fire example',
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController _mapController;
  late TextEditingController _latitudeController, _longitudeController;

  // firestore init
  final _firestore = FirebaseFirestore.instance;
  late GeoFlutterFire geo;
  late Stream<List<DocumentSnapshot>> stream;
  final radius = BehaviorSubject<double>.seeded(1.0);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    super.initState();
    _latitudeController = TextEditingController();
    _longitudeController = TextEditingController();

    geo = GeoFlutterFire();
    GeoFirePoint center = geo.point(latitude: 12.960632, longitude: 77.641603);
    stream = radius.switchMap((rad) {
      var collectionReference = _firestore.collection('locations');
//          .where('name', isEqualTo: 'darshan');
      return geo.collection(collectionRef: collectionReference).within(
          center: center, radius: rad, field: 'position', strictMode: true);

      /*
      ****Example to specify nested object****

      var collectionReference = _firestore.collection('nestedLocations');
//          .where('name', isEqualTo: 'darshan');
      return geo.collection(collectionRef: collectionReference).within(
          center: center, radius: rad, field: 'address.location.position');

      */
    });
  }

  @override
  void dispose() {
    _latitudeController.dispose();
    _longitudeController.dispose();
    radius.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GeoFlutterFire'),
          // actions: <Widget>[
          //   IconButton(
          //     onPressed: _mapController == null
          //         ? null
          //         : () {
          //             _showHome();
          //           },
          //     icon: Icon(Icons.home),
          //   )
          // ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            //   return StreamTestWidget();
            // }));
          },
          child: Icon(Icons.navigate_next),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    width: mediaQuery.size.width - 30,
                    height: mediaQuery.size.height * (1 / 3),
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(17.5136822, 78.3745627),
                        zoom: 15.0,
                      ),
                      markers: Set<Marker>.of(markers.values),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Slider(
                  min: 1,
                  max: 200,
                  divisions: 4,
                  value: _value,
                  label: _label,
                  activeColor: Colors.blue,
                  inactiveColor: Colors.blue.withOpacity(0.2),
                  onChanged: (double value) => changed(value),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: TextField(
                      controller: _latitudeController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: 'lat',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: TextField(
                      controller: _longitudeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'lng',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                  ),
                  MaterialButton(
                    color: Colors.blue,
                    onPressed: () {
                      final lat = double.parse(_latitudeController.text);
                      final lng = double.parse(_longitudeController.text);
                      _addPoint(lat, lng);
                    },
                    child: const Text(
                      'ADD',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              MaterialButton(
                color: Colors.amber,
                child: const Text(
                  'Add nested ',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  final lat = double.parse(_latitudeController.text);
                  final lng = double.parse(_longitudeController.text);
                  _addNestedPoint(lat, lng);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
//      _showHome();
      //start listening after map is created
      stream.listen((List<DocumentSnapshot> documentList) {
        _updateMarkers(documentList);
      });
    });
  }

  void _showHome() {
    _mapController.animateCamera(CameraUpdate.newCameraPosition(
      const CameraPosition(
        target: LatLng(17.5136822, 78.3745627),
        zoom: 15.0,
      ),
    ));
  }

  void _addPoint(double lat, double lng) {
    GeoFirePoint geoFirePoint = geo.point(latitude: lat, longitude: lng);
    _firestore
        .collection('locations')
        .add({'name': 'random name', 'position': geoFirePoint.data}).then((_) {
      print('added ${geoFirePoint.hash} successfully');
    });
  }

  //example to add geoFirePoint inside nested object
  void _addNestedPoint(double lat, double lng) {
    GeoFirePoint geoFirePoint = geo.point(latitude: lat, longitude: lng);
    _firestore.collection('nestedLocations').add({
      'name': 'random name',
      'address': {
        'location': {'position': geoFirePoint.data}
      }
    }).then((_) {
      print('added ${geoFirePoint.hash} successfully');
    });
  }

  void _addMarker(double lat, double lng) {
    final id = MarkerId(lat.toString() + lng.toString());
    final _marker = Marker(
      markerId: id,
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      infoWindow: InfoWindow(title: 'latLng', snippet: '$lat,$lng'),
    );
    setState(() {
      markers[id] = _marker;
    });
  }

  void _updateMarkers(List<DocumentSnapshot> documentList) {
    documentList.forEach((DocumentSnapshot document) {
      Map<String, dynamic> snapData = document.data() as Map<String,dynamic>;
      final GeoPoint point = snapData['position']['geopoint'];
      _addMarker(point.latitude, point.longitude);
    });
  }

  double _value = 20.0;
  String _label = '';

  changed(value) {
    setState(() {
      _value = value;
      _label = '${_value.toInt().toString()} kms';
      markers.clear();
    });
    radius.add(value);
  }
}