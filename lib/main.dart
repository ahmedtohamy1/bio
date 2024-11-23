import 'package:flutter/material.dart';
import 'package:link_in_bio/screens/home_screen.dart';
/* import 'package:link_in_bio/theme/theme.dart'; */

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Link in Bio',
      /*   theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme, */
      themeMode: ThemeMode.dark,
      home: HomeScreen(),
    );
  }
}
