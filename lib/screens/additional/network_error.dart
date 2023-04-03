import "package:flutter/material.dart";
import "package:xerox/utils/color_pallets.dart";

class NetworkError extends StatelessWidget {
  const NetworkError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Expanded(flex: 1, child: Text("")),
        Expanded(
            flex: 3,
            child: Image.asset(
              "assets/image/no_connet.png",
              fit: BoxFit.cover,
            )),
        Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(
                  height: 60,
                ),
                Text(
                  "Connection Lost !!",
                  style: TextStyle(fontSize: 30, color: ColorPallets.deepBlue),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "pls check you'r Connection!!",
                  style: TextStyle(
                    color: ColorPallets.pinkinshShadedPurple,
                    fontSize: 15,
                  ),
                )
              ],
            ))
      ],
    ));
  }
}
