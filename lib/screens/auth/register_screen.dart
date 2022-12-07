import "dart:io";

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import "../../utils/color_pallets.dart";

import "../../widgets/auth/sing_in_up_bar.dart";

class RegisterScreen extends StatefulWidget {
  final VoidCallback callLoginScreen;
  const RegisterScreen({
    super.key,
    required this.callLoginScreen,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? _userProfilePic;
  final formKeyRegister = GlobalKey<FormState>();
  bool _isLoading = false;

  Map<String, String> _userDetails = {
    "email": "",
    "password": "",
    "userName": ""
  };

  Future<void> registerUser() async {
    var msg = "Invalid Credentials !!!";
    var ProfilePicUrl = "";

    final isvalid = formKeyRegister.currentState!.validate();
    if (isvalid) {
      formKeyRegister.currentState!.save();
      if (_userProfilePic != null) {
        setState(() {
          _isLoading = true;
        });
        try {
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _userDetails["email"] as String,
            password: _userDetails["password"] as String,
          );

          final refPath = FirebaseStorage.instance
              .ref()
              .child("user")
              .child("${credential.user!.uid}.png");

          await refPath.putFile(_userProfilePic as File).whenComplete(() {});
          ProfilePicUrl = await refPath.getDownloadURL();
          print("PROILE PI URL ISSSS");
          print(ProfilePicUrl);
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(credential.user!.uid)
              .set({
            "userId": credential.user!.uid,
            "email": credential.user!.email,
            "profilePicUrl": ProfilePicUrl,
            "userName": _userDetails["userName"],
            "createdAt": Timestamp.now()
          });

          print("REGISTER SUCCESULLY");
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            msg = 'The password provided is too weak.';
          } else if (e.code == 'email-already-in-use') {
            msg = 'The account already exists for that email';
          }
          ScaffoldMessenger.of(context).clearSnackBars();

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
                      fontStyle: FontStyle.normal,
                      color: ColorPallets.white,
                    ),
                  )
                ],
              ),
            ),
          );
          setState(
            () {
              _isLoading = false;
            },
          );
        }
        // setState(() {
        //   _isLoading = false;
        // });
      } else {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: ColorPallets.deepBlue,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(
                  FontAwesomeIcons.triangleExclamation,
                  color: Colors.red,
                ),
                Text(
                  "add profile picture to register !!",
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.normal,
                    color: ColorPallets.white,
                  ),
                )
              ],
            ),
          ),
        );
      }
    }
  }

  Future<void> pickProfilePic() async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedFile == null) {
      return;
    }

    setState(() {
      _userProfilePic = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Create\nAccount",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 40,
                      color: ColorPallets.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.audiowide().fontFamily),
                ),
              )),
          Expanded(
              flex: 5,
              child: Container(
                constraints: const BoxConstraints(minWidth: 220),
                child: Form(
                  key: formKeyRegister,
                  child: ListView(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: _userProfilePic != null
                            ? FileImage(_userProfilePic as File)
                            : null,
                        backgroundColor: ColorPallets.lightPurplishWhile.withOpacity(.7),
                        child: _userProfilePic == null
                            ? InkWell(
                                onTap: pickProfilePic,
                                child: Image.asset(
                                  "assets/image/add_profile_border.png",
                                  color: ColorPallets.deepBlue,
                                  height: 60,
                                  width: 60,
                                ),
                              )
                            : null,
                      ),

                      // email form text filed
                      TextFormField(
                        key: const ValueKey("mail"),
                        cursorHeight: 22,
                        cursorWidth: 2,
                        cursorColor: ColorPallets.white,
                        style: const TextStyle(
                          fontSize: 18,
                          color: ColorPallets.white,
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          errorStyle: TextStyle(
                              color: ColorPallets.pinkinshShadedPurple),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorPallets.white)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: ColorPallets.white,
                            ),
                          ),
                          focusColor: ColorPallets.white,
                          label: Text(
                            "E-mail",
                            style: TextStyle(color: ColorPallets.white),
                          ),
                        ),
                        validator: (newMailId) {
                          if (newMailId!.isEmpty || !newMailId.contains('@')) {
                            return "Invalid EmailId";
                          }
                          return null;
                        },
                        onSaved: (newMailId) {
                          _userDetails["email"] = newMailId.toString().trim();
                        },
                      ),
                      TextFormField(
                        key: const ValueKey("userName"),
                        cursorHeight: 22,
                        cursorWidth: 2,
                        cursorColor: ColorPallets.white,
                        style: const TextStyle(
                          fontSize: 18,
                          color: ColorPallets.white,
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorPallets.white)),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: ColorPallets.white,
                              ),
                            ),
                            focusColor: ColorPallets.white,
                            label: Text(
                              "UserName",
                              style: TextStyle(color: ColorPallets.white),
                            ),
                            errorStyle: TextStyle(
                                color: ColorPallets.pinkinshShadedPurple)),
                        validator: (newUserName) {
                          if (newUserName!.isEmpty) {
                            return "InValid password";
                          }
                          return null;
                        },
                        onSaved: (newUserName) {
                          _userDetails["userName"] =
                              newUserName.toString().trim();
                        },
                      ),
                      TextFormField(
                        key: const ValueKey("passWoRd"),
                        cursorHeight: 22,
                        cursorWidth: 2,
                        cursorColor: ColorPallets.white,
                        style: const TextStyle(
                          fontSize: 18,
                          color: ColorPallets.white,
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          errorStyle: TextStyle(
                              color: ColorPallets.pinkinshShadedPurple),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorPallets.white)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: ColorPallets.white,
                            ),
                          ),
                          focusColor: ColorPallets.white,
                          label: Text(
                            "Password",
                            style: TextStyle(color: ColorPallets.white),
                          ),
                        ),
                        validator: (newPassword) {
                          if (newPassword!.isEmpty || newPassword.length < 6) {
                            return "password min of 6 char";
                          }
                          return null;
                        },
                        onSaved: (newPassword) {
                          _userDetails["password"] =
                              newPassword.toString().trim();
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      // signUp pages
                      SignUpBar(
                        isLoading: _isLoading,
                        label: "Register",
                        onPressed: registerUser,
                      ),
                      // nav from register to login
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "I'm a member  !!",
                              style: TextStyle(fontSize: 18),
                            ),
                            InkWell(
                              onTap: () {
                                if (widget.callLoginScreen != null) {
                                  widget.callLoginScreen();
                                }
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: ColorPallets.pinkinshShadedPurple,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
