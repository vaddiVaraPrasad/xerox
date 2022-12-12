import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pdf/widgets.dart' as Pw;
import 'package:xerox/utils/color_pallets.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 0, left: 0),
      child: Column(
        children: [
          const Expanded(
              flex: 2,
              child: TopCont(
                cityName: "Tadepalligudem",
              )),
          Expanded(
              flex: 8,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                      color: ColorPallets.lightPurplishWhile,
                      child: Row(
                        children: const [
                          Expanded(child: Text("df")),
                          Expanded(child: Text("fgf"))
                        ],
                      ),
                    )),
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
                    Expanded(
                        child: Container(
                      color: ColorPallets.pinkinshShadedPurple,
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: Container(
                      color: ColorPallets.yellowShadedPurple,
                    ))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
