import "dart:async";

import "package:connectivity_plus/connectivity_plus.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:internet_connectivity_checker/internet_connectivity_checker.dart";
import "../screens/additional/network_error.dart";
import "../screens/auth/auth_screen.dart";
import "../screens/nav_drawers/hidden_drawer.dart";

class CheckConnection extends StatefulWidget {
  const CheckConnection({super.key});

  @override
  State<CheckConnection> createState() => _CheckConnectionState();
}

class _CheckConnectionState extends State<CheckConnection> {

  @override
  Widget build(BuildContext context) {
    Stream<bool> stream = InternetConnectivity().isConnectedToInternet();
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData && (snapshot.data as bool) == true) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HiddenSideZoomDrawer();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return const AuthScreen();
              }
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const NetworkError();
        } else {
          return const NetworkError();
        }
      },
    );
  }
}
