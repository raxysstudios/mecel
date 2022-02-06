import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wordle/shared/models/input_key.dart';
import 'package:wordle/shared/services/language_assets.dart';
import 'package:wordle/shared/utils.dart';

import '../models/game_config.dart';

Future<GameConfig> loadConfig(String? languageName) async {
  final language = await findLanguage(languageName);
  final data = await rootBundle
      .loadString('assets/languages/${language.name}.json')
      .then((r) => json.decode(r) as Map<String, dynamic>);

  final words = json2list(data['words'])!.toSet();
  final layout = json2list(data['layout'])!
      .map((s) => s.characters.map((c) => InputKey(c)))
      .map((r) => r.toList())
      .toList();

  return GameConfig(
    language: language,
    words: words,
    layout: layout,
  );
}
