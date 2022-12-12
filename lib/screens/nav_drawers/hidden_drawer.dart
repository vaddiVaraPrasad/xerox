import "package:flutter/material.dart";
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:xerox/utils/color_pallets.dart';

import "./drawer_screen.dart";

import "../drawer_Screens/ContactUs.dart";
import "../drawer_Screens/about_us_Screen.dart";
import "../drawer_Screens/orders_Screen.dart";
import "../drawer_Screens/rewards_screen.dart";
import "../drawer_Screens/rateUs_Screens.dart";
import "./navBar.dart";

class HiddenSideZoomDrawer extends StatefulWidget {

  const HiddenSideZoomDrawer({super.key});

  @override
  State<HiddenSideZoomDrawer> createState() => _HiddenSideZoomDrawerState();
}

class _HiddenSideZoomDrawerState extends State<HiddenSideZoomDrawer> {
  var currentItem = MenuItems.home;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        menuBackgroundColor: ColorPallets.lightPurplishWhile.withOpacity(.7),
        borderRadius: 28,
        style: DrawerStyle.defaultStyle,
        angle: -10,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.linearToEaseOut,
        slideWidth: MediaQuery.of(context).size.width * 0.6,
        mainScreen: getScreen(),
        menuScreen: Builder(builder: (context) {
          return DrawerScreen(
            currentItem: currentItem,
            onSelectedItems: (item) {
              setState(() {
                currentItem = item;
                ZoomDrawer.of(context)!.close();
              });
            },
          );
        }),
      ),
    );
  }

  Widget getScreen() {
    if (currentItem == MenuItems.home) {
      return const ButtonNavigationBar();
    } else if (currentItem == MenuItems.orders) {
      return const OrderScreen();
    } else if (currentItem == MenuItems.rewards) {
      return const rewardsScreen();
    } else if (currentItem == MenuItems.contactUs) {
      return const ContactUs();
    } else if (currentItem == MenuItems.aboutUs) {
      return const AboutUs();
    } else {
      return const RateUsScreen();
    }
  }
}
