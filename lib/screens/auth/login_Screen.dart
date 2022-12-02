import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

import "../../utils/color_pallets.dart";

import "../../widgets/auth/sing_in_up_bar.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome\nBack",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 40,
                      color: ColorPallets.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.ubuntu().fontFamily),
                ),
              )),
          Expanded(
              flex: 6,
              child: Container(
                constraints: const BoxConstraints(minWidth: 220),
                child: Form(
                  child: ListView(
                    children: [
                      TextFormField(
                        key: const ValueKey("E-mail"),
                        cursorHeight: 22,
                        cursorWidth: 2,
                        style: const TextStyle(
                            fontSize: 18, color: ColorPallets.deepBlue),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          focusColor: ColorPallets.deepBlue,
                          label: Text("E-mail"),
                        ),
                        validator: (newMailId) {
                          if (newMailId!.isEmpty || !newMailId.contains('@')) {
                            return "Invalid EmailId";
                          }
                          return null;
                        },
                        onSaved: (newMailId) {},
                      ),
                      TextFormField(
                        obscureText: true,
                        key: const ValueKey("Password"),
                        cursorHeight: 22,
                        cursorWidth: 2,
                        style: const TextStyle(
                            fontSize: 18, color: ColorPallets.deepBlue),
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          focusColor: ColorPallets.deepBlue,
                          label: Text("Password"),
                        ),
                        validator: (newPassword) {
                          if (newPassword!.isEmpty || newPassword.length < 6) {
                            return "password min of 6 char";
                          }
                          return null;
                        },
                        onSaved: (newPassword) {},
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                "Forget Password ?",
                                style: TextStyle(
                                    color: ColorPallets.pinkinshShadedPurple,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SignInBar(
                        isLoading: true,
                        label: "Sign In",
                        onPressed: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Create a Account !!",
                              style: TextStyle(fontSize: 18),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                    color: ColorPallets.pinkinshShadedPurple,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 60,
                          width: 130,
                          padding: const EdgeInsets.symmetric(
                            vertical: 1,
                            horizontal: 2,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorPallets.deepBlue,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(18)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "image/google.png",
                                fit: BoxFit.cover,
                              ),
                              const Text(
                                "Sign In With Google",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: ColorPallets.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
