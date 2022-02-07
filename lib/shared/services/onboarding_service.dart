import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle/modules/game/services/config_service.dart';
import 'package:wordle/modules/language/services/language_service.dart';
import 'package:wordle/shared/models/game_config.dart';

Future<GameConfig> onboard(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  var language = prefs.getString('language');
  language ??= await changeLanguage(context, false);
  return await loadConfig(language);
}
