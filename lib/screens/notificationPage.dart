import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  static const routeName = "/notification page";
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text("this is notification Page")),
    );
  }
}
