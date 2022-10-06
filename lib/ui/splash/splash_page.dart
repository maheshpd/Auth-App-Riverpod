import 'package:auth_app_riverpod/root.dart';
import 'package:auth_app_riverpod/utils/label.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static const String route = "/splash";
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).whenComplete(() {
      Navigator.pushReplacementNamed(context, Root.route);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;
    return Scaffold(
      backgroundColor: scheme.primaryContainer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite,
              size: 80,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              Labels.appName,
              style: style.headlineLarge!
                  .copyWith(color: scheme.onPrimaryContainer),
            )
          ],
        ),
      ),
    );
  }
}
