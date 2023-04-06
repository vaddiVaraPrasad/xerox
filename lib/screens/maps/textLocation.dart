import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_google_places/flutter_google_places.dart";
import "package:provider/provider.dart";
import "package:xerox/utils/color_pallets.dart";

import "../../Global/api_keys.dart";
import "../../Provider/search_place.dart";
import "../../helpers/map_services.dart";
import "../../model/auto_complete_result.dart";
import "../../widgets/maps/buildListTile.dart";

class LocationText extends StatefulWidget {
  static const routeName = "/locationText";
  const LocationText({super.key});

  @override
  State<LocationText> createState() => _LocationTextState();
}

class _LocationTextState extends State<LocationText> {
  var placesSearchController = TextEditingController();

  Timer? debounce;

  @override
  Widget build(BuildContext context) {
    PlaceResult PlaceProvider = Provider.of<PlaceResult>(context, listen: true);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Enter Location!"),
        ),
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
                            List<AutoCompleteResult> emptyList = [];
                            PlaceProvider.setResult(emptyList);
                            placesSearchController.text = "";
                          },
                          icon: const Icon(Icons.cancel),
                        )
                      : null,
                ),
                onChanged: (value) {
                  setState(() {});
                  if (debounce == null) {
                    debounce =
                        Timer(const Duration(milliseconds: 700), () async {
                      if (value.length > 2) {
                        List<AutoCompleteResult> searchResults =
                            await MapServices().searchPlace(value);
                        PlaceProvider.setResult(searchResults);
                      } else {
                        List<AutoCompleteResult> emptyList = [];
                        PlaceProvider.setResult(emptyList);
                      }
                    });
                  } else {
                    if (debounce!.isActive) {
                      debounce!.cancel();
                    }
                    debounce =
                        Timer(const Duration(milliseconds: 700), () async {
                      if (value.length > 2) {
                        List<AutoCompleteResult> searchResults =
                            await MapServices().searchPlace(value);
                        PlaceProvider.setResult(searchResults);
                      } else {
                        List<AutoCompleteResult> emptyList = [];
                        PlaceProvider.setResult(emptyList);
                      }
                    });
                  }
                },
              ),
              PlaceProvider.allreturnedResult.isNotEmpty
                  ? Expanded(
                      child: SizedBox(
                        child: ListView(children: [
                          ...PlaceProvider.allreturnedResult
                              .map((e) => buildListTile(
                                    item: e,
                                    ctx: context,
                                  ))
                        ]),
                      ),
                    )
                  : const Expanded(
                    child:  Center(
                        child: Text(
                          "No Results .... yet",
                          style: TextStyle(fontSize: 26),
                        ),
                      ),
                  ),
            ],
          ),
        ));
  }
}
