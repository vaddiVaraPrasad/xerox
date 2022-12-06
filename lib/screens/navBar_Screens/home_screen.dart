import "package:flutter/material.dart";

import "package:firebase_auth/firebase_auth.dart";
import 'package:xerox/screens/dummy_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: Text("Log out"),
            ),
          ),
          SizedBox(
            height: 150,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(DummyScreen.routeName);
              },
              child: Text("navigate to dummy screen"))
        ],
      ),
    );
  }
}
