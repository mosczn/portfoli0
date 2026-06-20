import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'game/bingy_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Bingy is always viewed straight-on through the front of the tank, so
  // lock the app to portrait -- no point handling a landscape layout we'll
  // never use.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const BingyApp());
}

class BingyApp extends StatelessWidget {
  const BingyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bingy',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: GameWidget.controlled(gameFactory: BingyGame.new),
      ),
    );
  }
}
