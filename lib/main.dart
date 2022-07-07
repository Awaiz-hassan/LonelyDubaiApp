import 'package:flutter/material.dart';
import 'package:lonelydubai/Screens/main_tab_screen.dart';

import 'Screens/splash_screen.dart';
import 'Themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lonely Dubai',
      theme: AppTheme.getLightTheme(context),
      darkTheme: AppTheme.getDarkTheme(context),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

