import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:hidden_drawer_menu/hidden_drawer_menu.dart";
import 'package:line_icons/line_icons.dart';
import 'package:xerox/utils/color_pallets.dart';

import "../drawer_Screens/ContactUs.dart";
import "../drawer_Screens/about_us_Screen.dart";
import "../drawer_Screens/orders_Screen.dart";
import "../drawer_Screens/rewards_screen.dart";
import "./navBar.dart";

class HiddenCustomizedDrawer extends StatelessWidget {
  const HiddenCustomizedDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleHiddenDrawer(
      menu: Menu(),
      screenSelectedBuilder: (position, controller) {
        Widget screenCurrent = const Text("fdf");

        switch (position) {
          case 0:
            screenCurrent = const ButtonNavigationBar();
            break;
          case 1:
            screenCurrent = const OrderScreen();
            break;
          case 2:
            screenCurrent = const rewardsScreen();
            break;
          case 3:
            screenCurrent = const ContactUs();
            break;
          case 4:
            screenCurrent = const AboutUs();
            break;
        }
        return Scaffold(
          backgroundColor: ColorPallets.lightPurplishWhile,
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(FontAwesomeIcons.bars),
                onPressed: () {
                  controller.toggle();
                }),
          ),
          body: screenCurrent,
        );
      },
    );
  }
}

// class Menu extends StatefulWidget {
//   const Menu({super.key});

//   @override
//   State<Menu> createState() => _MenuState();
// }

// class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  

//   SimpleHiddenDrawerController _controller = SimpleHiddenDrawerController(
//     0,AnimatedDrawerController()
//   );

//   @override
//   void didChangeDependencies() {
//     _controller = SimpleHiddenDrawerController.of(context);
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.maxFinite,
//       height: double.maxFinite,
//       color: Colors.cyan,
//       padding: const EdgeInsets.all(8),
//       child: Center(
//         child: Column(
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   _controller.setSelectedMenuPosition(0);
//                 },
//                 child: Text("menu1")),
//             ElevatedButton(
//                 onPressed: () {
//                   _controller.setSelectedMenuPosition(1);
//                 },
//                 child: Text("Menu2"))
//           ],
//         ),
//       ),
//     );
//   }
// }


class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}