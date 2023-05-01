import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:xerox/Provider/current_user.dart";
import "package:xerox/utils/color_pallets.dart";

import "../../widgets/Items/no_items.dart";

class CartScreen extends StatefulWidget {
  static const routeName = "/cartScreen";
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isPdfLoading = false;

  @override
  Widget build(BuildContext context) {
    CurrentUser curUSer = Provider.of<CurrentUser>(context);
    print(curUSer.getUserId);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "On-Going Xerox",
            style: TextStyle(
              fontSize: 22,
              letterSpacing: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Orders")
              .where("customerId", isEqualTo: curUSer.getUserId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("something went wrong in streambuilder");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(child: NoOrders());
            }
            return Expanded(
                child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {},
            ));
          },
        ),
      ),
    );
  }
}
