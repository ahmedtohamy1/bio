import 'package:flutter/material.dart';
import 'package:link_in_bio/screens/home_screen.dart';

// Global flag for initialization status
bool _initialized = false;

// Lazy initialization function
Future<void> _initializeApp() async {
  if (_initialized) return;

  // Add any initialization logic here
  // Example: await Firebase.initializeApp();

  _initialized = true;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Link in Bio',
      theme: ThemeData(
        fontFamily: 'Geist',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Geist'),
          bodyMedium: TextStyle(fontFamily: 'Geist'),
          titleLarge: TextStyle(fontFamily: 'Geist'),
          titleMedium: TextStyle(fontFamily: 'Geist'),
          titleSmall: TextStyle(fontFamily: 'Geist'),
          labelLarge: TextStyle(fontFamily: 'Geist'),
          bodySmall: TextStyle(fontFamily: 'Geist'),
          labelSmall: TextStyle(fontFamily: 'Geist'),
        ),
      ),
      themeMode: ThemeMode.dark,
      home: FutureBuilder(
        // Initialize app only when needed
        future: _initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink(); // Use native loading indicator
          }
          return const HomeScreen();
        },
      ),
    );
  }
}
