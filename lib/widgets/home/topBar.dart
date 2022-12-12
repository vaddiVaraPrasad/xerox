import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/color_pallets.dart';

class TopCont extends StatelessWidget {
  final String cityName;

  const TopCont({
    super.key,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: ColorPallets.deepBlue,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          )),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Container(
              // color: ColorPallets.lightBlue,
              // margin: const EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                onPressed: () {
                  ZoomDrawer.of(context)!.toggle();
                },
                icon: const Icon(
                  FontAwesomeIcons.bars,
                  color: ColorPallets.white,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              // padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "   Current Location  ",
                          style: TextStyle(color: Colors.white60, fontSize: 16),
                        ),
                        Icon(
                          FontAwesomeIcons.caretDown,
                          color: ColorPallets.white,
                          size: 18,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      cityName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: ColorPallets.white,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: CircleAvatar(
                backgroundColor: ColorPallets.lightBlue.withOpacity(.5),
                child: const Icon(
                  FontAwesomeIcons.bell,
                  color: ColorPallets.white,
                )),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
