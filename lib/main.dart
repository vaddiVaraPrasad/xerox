import "package:connectivity_plus/connectivity_plus.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerox/firebase_options.dart';
import "package:xerox/helpers/sqlLite.dart";
import "package:xerox/screens/additional/network_error.dart";
import "package:xerox/screens/auth/auth_screen.dart";
import "package:xerox/screens/maps/textLocation.dart";
import "package:xerox/screens/nav_drawers/hidden_drawer.dart";
import 'package:xerox/screens/notificationPage.dart';
import 'package:xerox/screens/pdf/cutom_pdf_Render_Screen.dart';
import "package:provider/provider.dart";

import "./utils/color_pallets.dart";

import "./screens/auth/forget_password_Screen.dart";
import "./screens/nav_drawers/navBar.dart";

import "Provider/current_order.dart";
import "Provider/nearestShops.dart";
import "Provider/search_place.dart";
import "Provider/selected_shop.dart";
import 'screens/Order_Preview.dart';
import 'screens/pdf/nearestShopScreen.dart';
import 'screens/navBar_Screens/cart_Screen.dart';
import "screens/drawer_Screens/ContactUs.dart";
import "screens/navBar_Screens/home_screen.dart";
import "screens/drawer_Screens/about_us_Screen.dart";
import "screens/navBar_Screens/profile_Screen.dart";
import "screens/drawer_Screens/orders_Screen.dart";
import "screens/drawer_Screens/rewards_screen.dart";
import "screens/navBar_Screens/search_shop_screen.dart";
import "screens/pdf/images_grid_file.dart";
import "screens/pdf/pdf_filters_Screen.dart";
import "screens/maps/setLocationMaps.dart";

import "./Provider/current_user.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SQLHelpers.getDatabase;

  runApp(Xerox());
}

class Xerox extends StatefulWidget {
  Xerox({super.key});

  @override
  State<Xerox> createState() => _XeroxState();
}

class _XeroxState extends State<Xerox> {
  final Stream<ConnectivityResult> connectivityStream =
      Connectivity().onConnectivityChanged;

  final Stream<User?> authStateChanges =
      FirebaseAuth.instance.authStateChanges();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CurrentUser(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlaceResult(),
        ),
        ChangeNotifierProvider(
          create: (context) => NearestShopProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SelectedShop(),
        ),
        ChangeNotifierProvider(
          create: (context) => CurrentOrder(),
        )
      ],
      child: MaterialApp(
        title: "Xerox",
        debugShowCheckedModeBanner: false,
        // googlefonts.istokweb is for heading  .. when ever in need use there ..
        // googlefonts.lora is for body ..... so we defing the lora as global text theme
        theme: ThemeData(
          // canvasColor: ColorPallets.yellowShadedPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.ubuntuTextTheme(),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: ColorPallets.deepBlue,
            primary: ColorPallets.deepBlue,
          ),
          appBarTheme: const AppBarTheme(
              color: ColorPallets.deepBlue,
              systemOverlayStyle: SystemUiOverlayStyle.light),
        ),
        home: StreamBuilder<ConnectivityResult>(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data!) {
                  case ConnectivityResult.wifi:
                  case ConnectivityResult.mobile:
                    return StreamBuilder<User?>(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return const HiddenSideZoomDrawer();
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          return const AuthScreen();
                        }
                      },
                    );
                  default:
                    return const NetworkError();
                }
              } else {
                return const CircularProgressIndicator();
              }
            }),
        routes: {
          ForgetPasswordScreen.routeName: (context) =>
              const ForgetPasswordScreen(),
          AboutUs.routeName: (context) => const AboutDialog(),
          CartScreen.routeName: (context) => const CartScreen(),
          ContactUs.routeName: (context) => const ContactUs(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          OrderScreen.routeName: (context) => const OrderScreen(),
          ProfilePage.routeName: (context) => const ProfilePage(),
          rewardsScreen.routeName: (context) => const rewardsScreen(),
          SearchShop.routeName: (context) => const SearchShop(),
          OrderPreviewScreen.routeName: (context) => const OrderPreviewScreen(),
          CustomPDFPreview.routeName: (context) => const CustomPDFPreview(),
          PdfImagesRender.routeName: (context) => const PdfImagesRender(),
          PdfFilters.routeName: (context) => const PdfFilters(),
          NotificationPage.routeName: (context) => const NotificationPage(),
          DummyShops.routeName: (context) => const DummyShops(),
          ButtonNavigationBar.routeName: (context) =>
              const ButtonNavigationBar(),
          setLocationMaps.routeName: (context) => const setLocationMaps(),
          LocationText.routeName: (context) => const LocationText(),
          // HiddenSideZoomDrawer.routeName: (context) => const HiddenSideZoomDrawer()
        },
      ),
    );
  }
}
