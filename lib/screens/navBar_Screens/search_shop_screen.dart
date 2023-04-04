import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:xerox/Provider/current_user.dart';

class SearchShop extends StatelessWidget {
  static const routeName = "/searchScreen";
  const SearchShop({super.key});

  @override
  Widget build(BuildContext context) {
    var curretUSer = Provider.of<CurrentUser>(context, listen: true);
    return Center(
      // child: ElevatedButton(
      //     onPressed: () {
      //       Navigator.of(context).pushNamed(PdfFilters.routeName);
      //     },
      //     child: const Text("press to go filteres screen")),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text("press to print the user !!"),
            onPressed: () {
              print(curretUSer.getCurrentUserMap);
            },
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                curretUSer.setUserName("kanna");
              },
              child: Text("chage userName Kanna")),
          ElevatedButton(
              onPressed: () {
                curretUSer.setUserEmail("kanna@bmsce.ac.in");
              },
              child: Text("change user Email to kanna.bmace")),
          ElevatedButton(
              onPressed: () {
                curretUSer.setUserLocation("Tadepalligudem");
              },
              child: Text("chnage location ")),
        ],
      ),
    );
  }
}
