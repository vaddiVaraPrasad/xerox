import "package:flutter/material.dart";

class ProfilePage extends StatefulWidget {
  static const routeName = "/profileScreen";
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double value = 3;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Slider(
      value: value,
      min: 0,
      max: 50,
      onChanged: (value) => setState(() {
        this.value = value;
      }),
    ));
  }
}
