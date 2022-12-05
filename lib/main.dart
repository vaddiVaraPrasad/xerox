import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerox/firebase_options.dart';

import "./utils/color_pallets.dart";

import "./screens/auth/auth_screen.dart";
import "./screens/auth/forget_password_Screen.dart";
import "./screens/nav_drawers/navBar.dart";
import "./screens/nav_drawers/drawer_screen.dart";

import 'screens/home_screen.dart';
import "screens/about_us_Screen.dart";
import "screens/cart_Screen.dart";
import "screens/ContactUs.dart";
import "screens/orders_Screen.dart";
import "screens/profile_Screen.dart";
import "screens/rewards_screen.dart";
import "screens/search_shop_screen.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Xerox());
}

class Xerox extends StatelessWidget {
  const Xerox({super.key});

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
        textTheme: GoogleFonts.loraTextTheme(),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: ColorPallets.pinkinshShadedPurple,
          primary: ColorPallets.deepBlue,
        ),
        appBarTheme: const AppBarTheme(
            color: ColorPallets.deepBlue,
            systemOverlayStyle: SystemUiOverlayStyle.light),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ButtonNavigationBar();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return const AuthScreen();
          }
        },
      ),
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
        SearchShop.routeName: (context) => const SearchShop()
      },
    );
  }
}
