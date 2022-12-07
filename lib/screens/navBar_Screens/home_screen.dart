import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
            icon: Icon(FontAwesomeIcons.bars)),
        SizedBox(
          height: 150,
        ),
        Text(FirebaseAuth.instance.currentUser!.uid),
        Text(FirebaseAuth.instance.currentUser!.photoURL == null
            ? "photoUrl is null"
            : FirebaseAuth.instance.currentUser!.photoURL.toString()),
        Text(FirebaseAuth.instance.currentUser!.displayName == null
            ? "display is null"
            : FirebaseAuth.instance.currentUser!.displayName.toString()),
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(DummyScreen.routeName);
            },
            child: Text("navigate to dummy screen"))
      ],
    );
  }
}
