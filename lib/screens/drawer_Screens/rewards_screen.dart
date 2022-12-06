import "package:flutter/material.dart";
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:line_icons/line_icons.dart';

class rewardsScreen extends StatelessWidget {
  static const routeName = "/rewardScreen";
  const rewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IconButton(
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
              icon:const  Icon(LineIcons.bars)),
          Center(
            child: Text("this is rate us screens"),
          ),
        ],
      ),
    );
  }
}
