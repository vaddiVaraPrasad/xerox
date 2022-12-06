import "package:flutter/material.dart";
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:line_icons/line_icons.dart';

class RateUsScreen extends StatelessWidget {
  const RateUsScreen({super.key});

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IconButton(
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
              icon: Icon(LineIcons.bars)),
          Center(
            child: Text("this is rate us screen"),
          ),
        ],
      ),
    );
  }
}
