import "package:flutter/material.dart";
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/color_pallets.dart';

class AboutUs extends StatelessWidget {
  static const routeName = "/abouUs";
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: ColorPallets.deepBlue,
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(24),
            //   bottomRight: Radius.circular(24),
            // ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {
                      ZoomDrawer.of(context)!.toggle();
                    },
                    icon: const Icon(
                      FontAwesomeIcons.bars,
                      color: ColorPallets.white,
                    ),
                  ),
                  const Text(
                    "            About Us",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "XEROX PRIVATE LIMITED",
                textAlign: TextAlign.start,
                style: TextStyle(color: ColorPallets.deepBlue, fontSize: 24),
              ),
              Divider(
                color: ColorPallets.deepBlue,
                thickness: 1.5,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  "Zomato was founded as FoodieBay in 2008 by Deepinder Goyal and Pankaj Chaddah who worked for Bain & Company. The website started as a restaurant listing and recommendation portal. They renamed the company Zomato in 2010 as they were unsure if they would "),
            ],
          ),
        )
      ],
    ));
  }
}
