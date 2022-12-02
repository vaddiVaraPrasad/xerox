import "package:flutter/material.dart";

import "./backGround_paint.dart";
import "./login_Screen.dart";
import "./register_screen.dart";

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
                painter:
                    BackGroundPainter(animation: _animationController.view)),
          ),
          LoginScreen()
          // RegisterScreen()
        ],
      ),
    );
  }
}
