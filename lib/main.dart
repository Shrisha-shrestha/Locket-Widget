import 'package:flutter/material.dart';
import 'package:locket_widget/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: ColorScheme.fromSeed(seedColor: Colors.deepPurple).primaryContainer,
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}
