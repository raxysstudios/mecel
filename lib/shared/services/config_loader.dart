import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:wordle/shared/services/language_assets.dart';

import '../models/game_config.dart';

Future<GameConfig> loadConfig() async {
  final language = await findLanguage('lezgo');
  final data = await rootBundle
      .loadString('assets/languages/${language.name}.json')
      .then((r) => json.decode(r) as Map<String, dynamic>);
  final words = (data['words'] as Iterable<String>).toSet();

  return GameConfig(
    language: language,
    words: words,
  );
}
