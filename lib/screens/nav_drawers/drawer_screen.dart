import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerox/utils/color_pallets.dart';

class DrawerScreen extends StatefulWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItems;
  NetworkImage? userProfileImage;
  String? userProfileUrl;
  String userName = "kothikanna";

  DrawerScreen({
    super.key,
    required this.currentItem,
    required this.onSelectedItems,
  });

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  void initState() {
    getUserCredentials();
    super.initState();
  }

  void getUserCredentials() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    final userGet = await usersCollection.doc(userId).get();
    Map<String, dynamic> data = userGet.data() as Map<String, dynamic>;

    // FutureBuilder<DocumentSnapshot>(
    //   builder: (context, snapshot) {
    //     if (snapshot.hasError) {
    //        print("Something went wrong");
    //     }
    //     if (snapshot.hasData && !snapshot.data!.exists) {
    //       print("Document does not exist");
    //     }

    //   },
    //   future: usersCollection.doc(userId).get(),
    // );

    setState(() {
      print("inside the void setstae");
      widget.userName = data["userName"];
      widget.userProfileUrl = data["profilePicUrl"];
      widget.userProfileImage = NetworkImage(widget.userProfileUrl as String);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorPallets.lightPurplishWhile.withOpacity(.7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Spacer(
              flex: 4,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12.0, right: 8),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        FirebaseAuth.instance.currentUser!.photoURL == null
                            ? null
                            : NetworkImage(FirebaseAuth
                                .instance.currentUser!.photoURL as String),
                    backgroundColor: ColorPallets.pinkinshShadedPurple,
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: Column(
                    children: [
                      const Text(
                        "Hello",
                        style: TextStyle(
                          color: ColorPallets.deepBlue,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      Text(
                        (widget.userName.toString().length > 20)
                            ? "${widget.userName.toString().substring(0, 10)}..."
                            : widget.userName.toString(),
                        style: const TextStyle(
                            color: ColorPallets.deepBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
            const Spacer(
              flex: 1,
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Divider(
                  thickness: 2,
                  color: ColorPallets.deepBlue,
                )),
            const Spacer(
              flex: 1,
            ),
            Column(
              children: [
                ...MenuItems.all.map((e) => buildMenuItem(e)).toList(),
              ],
            ),
            const Spacer(
              flex: 1,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Divider(
                thickness: 2,
                color: ColorPallets.deepBlue,
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            ListTile(
              minLeadingWidth: 20,
              leading: const Icon(
                // ignore: deprecated_member_use
                FontAwesomeIcons.signOut,
                size: 20,
                color: ColorPallets.deepBlue,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(color: ColorPallets.deepBlue, fontSize: 18),
              ),
              onTap: () async {
                ZoomDrawer.of(context)!.close();
                await FirebaseAuth.instance.signOut();
              },
            ),
            const Spacer(
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(MenuItem item) {
    return ListTileTheme(
      selectedTileColor: ColorPallets.pinkinshShadedPurple.withOpacity(.6),
      child: ListTile(
        selected: widget.currentItem == item,
        minLeadingWidth: 20,
        leading: Icon(
          item.icon,
          size: 20,
          color: ColorPallets.deepBlue,
        ),
        title: Text(
          item.title,
          style: const TextStyle(color: ColorPallets.deepBlue, fontSize: 18),
        ),
        onTap: () => widget.onSelectedItems(item),
      ),
    );
  }
}

class MenuItem {
  final String title;
  final IconData icon;
  MenuItem({
    required this.title,
    required this.icon,
  });
}

class MenuItems {
  static final home = MenuItem(
    title: "Home",
    icon: FontAwesomeIcons.house,
  );

  static final orders = MenuItem(
    title: "Orders",
    icon: FontAwesomeIcons.shoppingCart,
  );

  static final rewards = MenuItem(
    title: "Rewards",
    icon: FontAwesomeIcons.gifts,
  );

  static final contactUs = MenuItem(
    title: 'ContactUs',
    icon: FontAwesomeIcons.envelope,
  );

  static final aboutUs = MenuItem(
    title: "AboutUs",
    icon: FontAwesomeIcons.info,
  );

  static final rateUs = MenuItem(
    title: "RateUs",
    icon: FontAwesomeIcons.star,
  );

  static final all = <MenuItem>[
    home,
    orders,
    rewards,
    contactUs,
    aboutUs,
    rateUs,
  ];
}
