import 'package:auth_app_riverpod/ui/auth/login_page.dart';
import 'package:flutter/material.dart';

class Root extends StatelessWidget {
  static const String route = "/";

  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
