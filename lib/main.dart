import 'package:flutter/material.dart';
import 'package:wordle/config/dark_theme.dart';
import 'package:wordle/config/keyboard_layouts.dart';
import 'package:wordle/config/light_theme.dart';
import 'package:wordle/modules/play/screens/play.dart';

import 'modules/home/screens/splash.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return MaterialApp(
      title: 'Wordle',
      theme: getLightTheme(colorScheme),
      darkTheme: getDarkTheme(colorScheme),
      home: SplashScreen(
        title: 'Wordle',
        future: Future.sync(() => null),
        onLoaded: (context) => Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute(
            builder: (context) => const PlayScreen(
              layoutStrings: lezgiRows,
              word: 'лезги',
              maxAttempts: 5,
            ),
          ),
        ),
      ),
    );
  }
}
