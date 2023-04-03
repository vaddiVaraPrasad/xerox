import "package:connectivity_plus/connectivity_plus.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerox/firebase_options.dart';
import "package:xerox/screens/additional/network_error.dart";
import "package:xerox/screens/auth/auth_screen.dart";
import "package:xerox/screens/nav_drawers/hidden_drawer.dart";
import 'package:xerox/screens/notificationPage.dart';
import 'package:xerox/screens/pdf/cutom_pdf_Render_Screen.dart';
import "package:xerox/utils/check_connection.dart";

import "./utils/color_pallets.dart";

import "./screens/auth/forget_password_Screen.dart";
import "./screens/nav_drawers/navBar.dart";

import 'screens/dummy_screen.dart';
import 'screens/dummyshopsScreen.dart';
// import 'screens/home/home_nav_drawer_stack.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(Xerox());
}

class Xerox extends StatelessWidget {
  Xerox({super.key});

  final Stream<ConnectivityResult> connectivityStream =
      Connectivity().onConnectivityChanged;
  final Stream<User?> authStateChanges =
      FirebaseAuth.instance.authStateChanges();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Xerox",
      debugShowCheckedModeBanner: false,
      // googlefonts.istokweb is for heading  .. when ever in need use there ..
      // googlefonts.lora is for body ..... so we defing the lora as global text theme
      theme: ThemeData(
        // canvasColor: ColorPallets.yellowShadedPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.ubuntuTextTheme(),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: ColorPallets.pinkinshShadedPurple,
          primary: ColorPallets.deepBlue,
        ),
        appBarTheme: const AppBarTheme(
            color: ColorPallets.deepBlue,
            systemOverlayStyle: SystemUiOverlayStyle.light),
      ),
      // home: StreamBuilder(
      //       stream: FirebaseAuth.instance.authStateChanges(),
      //       builder: (context, snapshot) {
      //         if (snapshot.hasData) {
      //           return const HiddenSideZoomDrawer();
      //         } else if (snapshot.connectionState == ConnectionState.waiting) {
      //           return const CircularProgressIndicator();
      //         } else {
      //           return const AuthScreen();
      //         }
      //       },
      //     ),
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
                        ;
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
        DummyScreen.routeName: (context) => const DummyScreen(),
        CustomPDFPreview.routeName: (context) => const CustomPDFPreview(),
        PdfImagesRender.routeName: (context) => const PdfImagesRender(),
        PdfFilters.routeName: (context) => const PdfFilters(),
        NotificationPage.routeName: (context) => const NotificationPage(),
        DummyShops.routeName: (context) => const DummyShops(),
        ButtonNavigationBar.routeName: (context) => const ButtonNavigationBar(),
        // HiddenSideZoomDrawer.routeName: (context) => const HiddenSideZoomDrawer()
      },
    );
  }
}


// import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:xerox/screens/additional/network_error.dart';
// import 'package:xerox/screens/auth/auth_screen.dart';
// import 'package:xerox/screens/nav_drawers/hidden_drawer.dart';

// import 'firebase_options.dart';

// void main() async {
//     WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final Stream<ConnectivityResult> connectivityStream =
//       Connectivity().onConnectivityChanged;
//   final Stream<User?> authStateChanges = FirebaseAuth.instance.authStateChanges();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: StreamBuilder<ConnectivityResult>(
//           stream: connectivityStream,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               switch (snapshot.data!) {
//                 case ConnectivityResult.wifi:
//                 case ConnectivityResult.mobile:
//                   return StreamBuilder<User?>(
//                     stream: authStateChanges,
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         return HiddenSideZoomDrawer();;
//                       } 
//                       else if( snapshot.connectionState == ConnectionState.waiting){
//                         return CircularProgressIndicator();
//                       }
//                       else {
//                         return AuthScreen();
//                       }
//                     },
//                   );
//                 default:
//                   return NetworkError();
//               }
//             } else {
//               return CircularProgressIndicator();
//             }
//           }),
//     );
//   }
// }

// // class AuthScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Auth Screen'),
// //       ),
// //       body: Center(
// //         child: Text('Please log in.'),
// //       ),
// //     );
// //   }
// // }

// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Main Screen'),
//       ),
//       body: Center(
//         child: Text('You are logged in.'),
//       ),
//     );
//   }
// }

// class NoInternetScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('No Internet'),
//       ),
//       body: Center(
//         child: Text('Please check your internet connection.'),
//       ),
//     );
//   }
// }
