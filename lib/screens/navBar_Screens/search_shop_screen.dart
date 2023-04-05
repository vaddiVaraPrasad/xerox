import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:xerox/Provider/current_user.dart';
import 'package:xerox/helpers/sqlLite.dart';

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
              onPressed: () async {
                final docRef = FirebaseFirestore.instance
                    .collection("Users")
                    .doc(curretUSer.getUserId);
                docRef.get().then(
                  (DocumentSnapshot doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    print(data);
                  },
                  onError: (e) => print("ERROR in getting documets $e"),
                );
              },
              child: Text("check user present or not !!")),
          ElevatedButton(
              onPressed: () {
                SQLHelpers.getAllTableData("users");
              },
              child: Text("print the data from table")),
          ElevatedButton(
              onPressed: () {
                SQLHelpers.getUserById(FirebaseAuth.instance.currentUser!.uid);
              },
              child: Text("get user by ID")),
          ElevatedButton(
              onPressed: () {
                print(FirebaseAuth.instance.currentUser!.uid);
                print(curretUSer.getUserId);
              },
              child: Text("print the data from table")),
        ],
      ),
    );
  }
}
