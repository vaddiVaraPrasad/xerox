import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerox/firebase_options.dart';

import "./utils/color_pallets.dart";

import "./screens/auth/auth_screen.dart";
import "./screens/home/home_screen.dart";
import "./screens/auth/forget_password_Screen.dart";

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
            return const HomeScreen();
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
      },
    );
  }
}
