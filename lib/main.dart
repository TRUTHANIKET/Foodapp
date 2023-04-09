import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food/views/Login.dart';
import 'package:food/views/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      theme: ThemeData.dark(),
      home: const Login(),
    );
  }
}
