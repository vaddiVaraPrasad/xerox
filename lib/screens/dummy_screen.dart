import 'package:flutter/material.dart';

class DummyScreen extends StatelessWidget {
  static const routeName = "/dummyScreen";
  const DummyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("dummySCreen"),
      ),
    );
  }
}
