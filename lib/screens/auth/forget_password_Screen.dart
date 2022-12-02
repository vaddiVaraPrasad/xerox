import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/color_pallets.dart';

import "../../widgets/IconButton.dart";

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = "/forgetPassword";
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> sendPasswordLink() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text(
              "email to reset password has send to ur mail pls check"),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.done,
                  size: 30,
                ))
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      var msg = e.code;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: ColorPallets.deepBlue,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                FontAwesomeIcons.triangleExclamation,
                color: Colors.red,
              ),
              Text(
                msg,
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: ColorPallets.white,
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 90,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomIconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: FontAwesomeIcons.chevronLeft,
                      iconColor: ColorPallets.white,
                      backGroundColor: ColorPallets.deepBlue,
                      size: 40,
                      iconSize: 16,
                    )
                  ]),
            ),
          ),
          Expanded(
              flex: 5,
              child: Image.asset(
                "image/forgotPassword.png",
                fit: BoxFit.cover,
              )),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Enter Your Email and we will send you a password reset link",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20, color: Color.fromARGB(255, 187, 67, 230)),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(label: Text("email")),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: sendPasswordLink,
                      child: Container(
                        height: 50,
                        width: 180,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorPallets.deepBlue.withOpacity(.9)),
                        child: const Text(
                          "Send Link",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorPallets.white,
                              fontSize: 24,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
