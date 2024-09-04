import 'package:flutter/material.dart';
import 'package:locket_widget/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
