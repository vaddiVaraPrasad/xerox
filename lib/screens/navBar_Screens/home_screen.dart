import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pdf/widgets.dart' as Pw;
import 'package:xerox/utils/color_pallets.dart';

import '../../widgets/home/ScanDocument.dart';
import '../../widgets/home/UploadDoc.dart';
import '../../widgets/home/inviteCont.dart';
import '../../widgets/home/topBar.dart';
import "../nav_drawers/drawer_screen.dart";

import '../dummy_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 0, right: 0, left: 0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: ColorPallets.deepBlue,
              ),
            ),
            Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 0),
                  child: TopCont(
                    cityName: "Tadepalligudem",
                    ctx: context,
                  ),
                )),
            Expanded(
                flex: 25,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      const Expanded(flex: 4, child: InviteCont()),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: const Text(
                              "Select  Option",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorPallets.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Expanded(flex: 3, child: UploadDoc()),
                      const SizedBox(
                        height: 20,
                      ),
                      const Expanded(flex: 3, child: ScanDoc())
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
