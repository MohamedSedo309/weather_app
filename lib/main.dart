import 'package:flutter/material.dart';
import 'app_router.dart';

void main() {
  runApp(Weather_app(app_router: App_Router()));
}

class Weather_app extends StatelessWidget {
  final App_Router app_router;

  const Weather_app({super.key, required this.app_router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: app_router.generateRoute,
    );
  }
}
