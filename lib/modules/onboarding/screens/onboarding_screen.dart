import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle/modules/game/services/config_service.dart';
import 'package:wordle/modules/language/services/language_service.dart';
import 'package:wordle/modules/onboarding/widgets/splash.dart';
import 'package:wordle/shared/models/game_config.dart';

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
    language ??= await changeLanguage(context, false);
    config = await loadConfig(language);
  }

  @override
  Widget build(BuildContext context) {
    return const Splash('mecel');
  }
}
