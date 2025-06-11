import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanctuarai/services/auth_service.dart';
import 'package:sanctuarai/views/pages/auth%20pages/welcome_page.dart';
import 'package:sanctuarai/views/widget_tree.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authService,
      builder: (context, authService, child) {
        return StreamBuilder<User?>(
          stream: authService.authStateChanges,
          builder: (context, snapshot) {
            print("🔥 Snapshot user: ${snapshot.data}");
            Widget widget;
            if (snapshot.connectionState == ConnectionState.waiting) {
              widget = CircularProgressIndicator.adaptive();
            } else if (snapshot.hasData) {
              widget =const WidgetTree();
            } else {
              widget =const WelcomePage();
            }
            return widget;
          },
        );
      },
    );
  }
}
