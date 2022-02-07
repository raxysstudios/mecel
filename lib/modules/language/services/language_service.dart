import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle/shared/models/language.dart';

import '../screens/languages.dart';

Future<String?> changeLanguage(
  BuildContext context, [
  bool canSkip = true,
]) async {
  final route = MaterialPageRoute<Language>(
    builder: (context) => const LanguagesScreen(),
  );
  final language = canSkip
      ? await Navigator.pushReplacement(context, route)
      : await Navigator.push(context, route);
  if (language != null) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language.name);
  }
  return language?.name;
}
