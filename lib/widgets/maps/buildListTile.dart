import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xerox/Provider/current_user.dart';
import 'package:xerox/helpers/map_services.dart';
import 'package:xerox/utils/color_pallets.dart';
import "../../model/auto_complete_result.dart";

class buildListTile extends StatefulWidget {
  AutoCompleteResult item;
  BuildContext ctx;
  buildListTile({super.key, required this.item, required this.ctx});

  @override
  State<buildListTile> createState() => _buildListTileState();
}

class _buildListTileState extends State<buildListTile> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    CurrentUser curUser = Provider.of<CurrentUser>(context);
    double width = MediaQuery.of(context).size.width - 20;
    return GestureDetector(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        FocusScope.of(context).unfocus();
        var res =
            await MapServices().getPlaceDetails(widget.item.placeId.toString());
        curUser.setUserLatitudeLogitude(res["geometry"]["location"]["lat"],
            res["geometry"]["location"]["lng"]);
        curUser.setUserPlaceName(
            widget.item.structuredFormatting!.mainText.toString());
        curUser.setUserContryName("India");
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      },
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              padding:
                  const EdgeInsets.only(left: 15, right: 5, top: 7, bottom: 7),
              height: 70,
              width: width,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 30,
                        color: ColorPallets.deepBlue,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        width: width - 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.item.structuredFormatting!.mainText
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: ColorPallets.deepBlue,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              widget.item.structuredFormatting!.secondaryText
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: ColorPallets.deepBlue,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    thickness: 2,
                  )
                ],
              )),
    );
  }
}
