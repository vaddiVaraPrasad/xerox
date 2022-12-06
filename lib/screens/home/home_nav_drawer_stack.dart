// import "package:flutter/material.dart";
// import 'package:xerox/utils/color_pallets.dart';

// import "../nav_drawers/drawer_screen.dart";
// import "../nav_drawers/navBar.dart";

// class HomeNavDrawerSlider extends StatefulWidget {
//   const HomeNavDrawerSlider({super.key});

//   @override
//   State<HomeNavDrawerSlider> createState() => _HomeNavDrawerSliderState();
// }

// class _HomeNavDrawerSliderState extends State<HomeNavDrawerSlider> {
//   double xOffset = 0;
//   double yOffset = 0;
//   double scaleFactor = 1;

//   bool isDrawerOpen = false;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         const HiddenDrawer(),
//         AnimatedContainer(
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(70)),
//           transform: Matrix4.translationValues(xOffset, yOffset, 0)
//             ..scale(scaleFactor),
//           duration: const Duration(milliseconds: 300),
//           child: const ButtonNavigationBar(),
//         ),
//         AnimatedContainer(
//           transform: Matrix4.translationValues(xOffset, yOffset, 0)
//             ..scale(scaleFactor),
//           duration: const Duration(milliseconds: 300),
//           child: Align(
//               alignment: Alignment.topLeft,
//               child: !isDrawerOpen
//                   ? GestureDetector(
//                       onTap: () {
//                         print("menu button is presssed on home screen");
//                         setState(() {
//                           xOffset = 230;
//                           yOffset = 150;
//                           scaleFactor = .6;
//                           isDrawerOpen = true;
//                         });
//                       },
//                       child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(40),
//                             color: ColorPallets.deepBlue,
//                           ),
//                           padding: const EdgeInsets.all(8),
//                           margin: const EdgeInsets.only(top: 40, left: 25),
//                           child: const Icon(
//                             Icons.menu,
//                             color: ColorPallets.white,
//                             size: 18,
//                           )),
//                     )
//                   : GestureDetector(
//                       onTap: () {
//                         print("back button is pressed ");
//                         setState(() {
//                           xOffset = 0;
//                           yOffset = 0;
//                           scaleFactor = 1;
//                           isDrawerOpen = false;
//                         });
//                       },
//                       child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(40),
//                             color: ColorPallets.deepBlue,
//                           ),
//                           padding: const EdgeInsets.only(
//                             left: 10,
//                             right: 8,
//                             top: 8,
//                             bottom: 8,
//                           ),
//                           margin: const EdgeInsets.only(top: 40, left: 25),
//                           child: const Icon(
//                             Icons.arrow_back_ios,
//                             size: 30,
//                             color: ColorPallets.white,
//                           )),
//                     )),
//         )
//       ],
//     );
//   }
// }
