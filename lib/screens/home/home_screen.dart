import "package:flutter/material.dart";

import "package:firebase_auth/firebase_auth.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: Text("Log out")),
          ),
        ],
      ),
    );
  }
}
