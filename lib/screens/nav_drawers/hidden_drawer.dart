import "package:flutter/material.dart";
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import "./drawer_screen.dart";

class HiddenSideZoomDrawer extends StatefulWidget {
  const HiddenSideZoomDrawer({super.key});

  @override
  State<HiddenSideZoomDrawer> createState() => _HiddenSideZoomDrawerState();
}

class _HiddenSideZoomDrawerState extends State<HiddenSideZoomDrawer> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: DrawerScreen(),
      mainScreen: Text("d"),
    );
  }
}


