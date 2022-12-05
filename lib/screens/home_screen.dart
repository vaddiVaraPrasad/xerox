import "package:flutter/material.dart";

import "package:firebase_auth/firebase_auth.dart";

class HomeScreen extends StatelessWidget {
  static const routeName = "/homeScreen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
        },
        child: Text("Log out"),
      ),
    );
  }
}
