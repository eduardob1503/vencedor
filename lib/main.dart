// lib/main.dart
import 'package:flutter/material.dart';
import 'pages/tela_login.dart';

void main() {
  runApp(AprendaSApp());
}

class AprendaSApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AprendaS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
