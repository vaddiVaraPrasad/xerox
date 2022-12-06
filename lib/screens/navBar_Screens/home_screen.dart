import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        Center(
          child: ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: Text("Log out"),
          ),
        ),
        SizedBox(
          height: 150,
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(DummyScreen.routeName);
            },
            child: Text("navigate to dummy screen"))
      ],
    );
  }
}
