import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Jogos',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: Home(), // Define a tela inicial como a tela de Dashboard
    );
  }
}
