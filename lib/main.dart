import 'package:flutter/material.dart';
import 'package:game2048_app/widgets/board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game of 2048',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const Game(),
    );
  }
}

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game of 2048"),
        centerTitle: false,
        actions: [
          Switch(
            value: false,
            activeColor: Colors.white,
            onChanged: (_) => {},
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Board(),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
