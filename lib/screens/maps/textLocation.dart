import "package:flutter/material.dart";
import "package:flutter_google_places/flutter_google_places.dart";
import "package:xerox/utils/color_pallets.dart";

import "../../Global/api_keys.dart";

class LocationText extends StatefulWidget {
  static const routeName = "/locationText";
  const LocationText({super.key});

  @override
  State<LocationText> createState() => _LocationTextState();
}

class _LocationTextState extends State<LocationText> {
  var placesSearchController = TextEditingController();

  void result(String placeVal) async {
    var p = await PlacesAutocomplete.show(
      context: context,
      apiKey: GlobalApiKeys.apiKeys,
      mode: Mode.overlay, // Mode.fullscreen
      language: "fr",
    );
    print(p);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Enter Location!")),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        // padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              showCursor: true,
              controller: placesSearchController,
              style: const TextStyle(color: ColorPallets.deepBlue),
              onChanged: (val) {},
              decoration: InputDecoration(
                hintText: "Search by Locality , PinCode or Area",
                hintStyle: const TextStyle(
                    color: ColorPallets.deepBlue,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: placesSearchController.text != ""
                    ? IconButton(
                        onPressed: () {
                          placesSearchController.text = "";
                        },
                        icon: const Icon(Icons.cancel),
                      )
                    : null,
              ),
            )
          ],
        ),
      ),
    );
  }
}
