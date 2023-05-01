import "package:flutter/material.dart";
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/color_pallets.dart';

class ContactUs extends StatelessWidget {
  static const routeName = "/contactUs";
  const ContactUs({super.key});

  void launchWebsite() async {
    Uri uri = Uri.https("www.google.com");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not open the map.';
    }
  }

  void launchMail() async {
    Uri uri = Uri(
      scheme: "mailto",
      path: "varaprasadvaddi04@gmail.com",
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not open the map.';
    }
  }

  void launchSms() async {
    final uri = Uri(
      scheme: "sms",
      path: "+919849231892",
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not open the map.';
    }
  }

  void launchPhoneCall() async {
    final uri = Uri(
      scheme: "tel",
      path: "+919849231892",
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not open the map.';
    }
  }

  void lauchWhatsApp() async {
    var phone = "+919133931892";
    var message = "hi";
    final uri =
        Uri.parse("whatsapp://send?phone=$phone&text=${Uri.parse(message)}");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not open the map.';
    }
  }

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
                    "            Contact Us",
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
            children: [
              const Text(
                "XEROX PRIVATE LIMITED",
                textAlign: TextAlign.start,
                style: TextStyle(color: ColorPallets.deepBlue, fontSize: 24),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                color: ColorPallets.deepBlue,
                thickness: 1.5,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Office Address",
                style: TextStyle(
                  fontSize: 20,
                  color: ColorPallets.deepBlue,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Xerox Office , Classroom-404 , 4th Floor , PlatinumBlock , B.M.S College Of Engineering , Opp Bull Temple , Basavannagudi , Bangaloru , Karanataka  ",
                maxLines: 5,
              ),
              TextButton.icon(
                  onPressed: () {
                    MapsLauncher.launchCoordinates(12.9410, 77.5655);
                  },
                  icon: const Icon(FontAwesomeIcons.locationArrow),
                  label: const Text("Visit Our Office")),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Social Media",
                style: TextStyle(
                  fontSize: 20,
                  color: ColorPallets.deepBlue,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: launchMail,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      height: 30,
                      width: 30,
                      child: Image.asset(
                        "assets/image/mail.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: launchPhoneCall,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      height: 30,
                      width: 30,
                      child: Image.asset(
                        "assets/image/phone.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: launchSms,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      height: 30,
                      width: 30,
                      child: Image.asset(
                        "assets/image/text_msg.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: lauchWhatsApp,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        "assets/image/whatsapp.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: launchWebsite,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        "assets/image/chrome.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}
