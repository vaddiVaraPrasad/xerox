import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xerox/utils/color_pallets.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          ...MenuItems.all.map((e) => buildMenuItem(e)).toList(),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}

Widget buildMenuItem(MenuItem item) {
  return ListTile(
    minLeadingWidth: 10,
    leading: Icon(item.icon),
    title: Text(item.title),
    onTap: () {},
  );
}

class MenuItem {
  final String title;
  final IconData icon;
  MenuItem({
    required this.title,
    required this.icon,
  });
}

class MenuItems {
  static final home = MenuItem(
    title: "Home",
    icon: LineIcons.home,
  );

  static final orders = MenuItem(
    title: "Orders",
    icon: LineIcons.shoppingCart,
  );

  static final rewards = MenuItem(
    title: "Rewards",
    icon: FontAwesomeIcons.gifts,
  );

  static final contactUs = MenuItem(
    title: 'ContactUs',
    icon: FontAwesomeIcons.envelope,
  );

  static final aboutUs = MenuItem(
    title: "AboutUs",
    icon: FontAwesomeIcons.circleInfo,
  );

  static final rateUs = MenuItem(
    title: "RateUs",
    icon: FontAwesomeIcons.star,
  );

  static final all = <MenuItem>[
    home,
    orders,
    rewards,
    contactUs,
    aboutUs,
    rateUs,
  ];
}
