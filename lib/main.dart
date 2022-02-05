import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordle/config/dark_theme.dart';
import 'package:wordle/config/light_theme.dart';
import 'package:wordle/modules/play/screens/play.dart';
import 'package:wordle/store.dart';

import 'modules/home/screens/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return MaterialApp(
      title: 'Mecel',
      theme: getLightTheme(colorScheme).copyWith(
        textTheme: GoogleFonts.robotoSlabTextTheme(),
      ),
      darkTheme: getDarkTheme(colorScheme).copyWith(
        textTheme: GoogleFonts.robotoSlabTextTheme(),
      ),
      home: SplashScreen(
        title: 'MECEL',
        future: Future.sync(() => null),
        onLoaded: (context) => Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute(
            builder: (context) => const PlayScreen(
              language: lezgi,
              maxAttempts: 6,
            ),
          ),
        ),
      ),
    );
  }
}
