import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/color_pallets.dart';

class UploadDoc extends StatelessWidget {
  const UploadDoc({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: ColorPallets.pinkinshShadedPurple.withOpacity(.2),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: ColorPallets.pinkinshShadedPurple.withOpacity(.2),
            borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            Expanded(
                flex: 5,
                child: Image.asset(
                  "assets/image/documentUpload.png",
                  fit: BoxFit.cover,
                )),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Upload Your \nDocument",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorPallets.deepBlue,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Icon(
                    FontAwesomeIcons.arrowRight,
                    color: ColorPallets.deepBlue,
                    size: 28,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
