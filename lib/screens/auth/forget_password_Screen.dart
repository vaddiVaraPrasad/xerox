import "package:flutter/material.dart";

class ForgetPasswordScreen extends StatelessWidget {
  static const routeName = "/forgetPassword";
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("forget password screen"),
      ),
    );
  }
}
