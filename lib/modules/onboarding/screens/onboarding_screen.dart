import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle/models/game_config.dart';
import 'package:wordle/modules/game/screens/help.dart';
import 'package:wordle/modules/game/services/config_service.dart';
import 'package:wordle/modules/language/services/language_service.dart';
import 'package:wordle/modules/onboarding/widgets/splash.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  GameConfig? config;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(
      const Duration(seconds: 1),
      onboard,
    ).then((_) => startGame(context, config!));
  }

  Future<void> onboard() async {
    final prefs = await SharedPreferences.getInstance();
    var language = prefs.getString('language');
    bool first = language == null;
    language ??= await changeLanguage(context, false);

    config = await loadConfig(language);
    if (first) {
      await Future.wait<void>([
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => Provider.value(
              value: config!.localization,
              builder: (context, _) => const HelpScreen(),
            ),
          ),
        ),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Splash('mecel');
  }
}
