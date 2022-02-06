import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:wordle/shared/models/language.dart';
import 'package:wordle/shared/utils.dart';

Future<List<Language>> loadLanguages({bool sort = false}) async {
  final data = await rootBundle
      .loadString('assets/languages.json')
      .then((r) => json.decode(r) as List);
  final languages = listFromJson(
    data,
    (dynamic j) => Language.fromJson(j as Map<String, dynamic>),
  );
  if (sort) {
    languages.sort((a, b) => a.name.compareTo(b.name));
  }
  return languages;
}

Future<Language> findLanguage(String name) async {
  final languages = await loadLanguages();
  return languages.firstWhere(
    (l) => l.name == name,
    orElse: () => languages.first,
  );
}
