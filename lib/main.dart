import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mecel/config/dark_theme.dart';
import 'package:mecel/config/light_theme.dart';
import 'package:mecel/modules/onboarding/screens/onboarding_screen.dart';

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
    final lightTheme = getLightTheme(colorScheme);
    final darkTheme = getDarkTheme(colorScheme);
    return MaterialApp(
      title: 'Mecel',
      theme: lightTheme.copyWith(
        textTheme: GoogleFonts.robotoSlabTextTheme(
          lightTheme.textTheme,
        ),
      ),
      darkTheme: darkTheme.copyWith(
        textTheme: GoogleFonts.robotoSlabTextTheme(
          darkTheme.textTheme,
        ),
      ),
      home: const OnboardingScreen(),
    );
  }
}
