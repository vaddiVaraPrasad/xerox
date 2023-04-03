import "dart:async";

import "package:connectivity_plus/connectivity_plus.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
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
  ConnectivityResult _connectivityResult = ConnectivityResult.mobile;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConfirmationResult> _streamSubscription;

  Future<void> initConnnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectivityResult = result;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initConnnectivity();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  // Widget build(BuildContext context) {
  //   Stream<bool> stream = InternetConnectivity().isConnectedToInternet();
  //   // return StreamBuilder(
  //   //   stream: stream,
  //   //   builder: (context, snapshot) {
  //   //     print("outer snapshot");
  //   //     print(snapshot.connectionState);
  //   //     if (snapshot.hasData) {
  //   //       return StreamBuilder(
  //   //         stream: FirebaseAuth.instance.authStateChanges(),
  //   //         builder: (context, firebasesnapshot) {
  //   //           print("firebase data result");
  //   //           print(firebasesnapshot.connectionState);
  //   //           if (firebasesnapshot.hasData) {
  //   //             return const HiddenSideZoomDrawer();
  //   //           } else if (firebasesnapshot.connectionState ==
  //   //               ConnectionState.waiting) {
  //   //             return const CircularProgressIndicator();
  //   //           } else {
  //   //             return const AuthScreen();
  //   //           }
  //   //         },
  //   //       );
  //   //     } else if (snapshot.connectionState == ConnectionState.waiting) {
  //   //       return const NetworkError();
  //   //     } else {
  //   //       return const NetworkError();
  //   //     }
  //   //   },
  //   // );
  //   return StreamBuilder(
  //           stream: FirebaseAuth.instance.authStateChanges(),
  //           builder: (context, firebasesnapshot) {
  //             print("firebase data result");
  //             print(firebasesnapshot.connectionState);
  //             if (firebasesnapshot.hasData) {
  //               return const HiddenSideZoomDrawer();
  //             } else if (firebasesnapshot.connectionState ==
  //                 ConnectionState.waiting) {
  //               return const CircularProgressIndicator();
  //             } else {
  //               return const AuthScreen();
  //             }
  //           },
  //         );
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(_connectivityResult.toString()),
      ),
    );
  }
}
