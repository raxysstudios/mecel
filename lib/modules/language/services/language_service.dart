import 'package:flutter/material.dart';
import 'package:mecel/models/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/languages.dart';

Future<String?> changeLanguage(
  BuildContext context, [
  bool canSkip = true,
]) async {
  final language = await Navigator.push(
    context,
    MaterialPageRoute<Language>(
      builder: (context) => WillPopScope(
        child: const LanguagesScreen(),
        onWillPop: () async => canSkip,
      ),
    ),
  );
  if (language != null) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language.name);
  }
  return language?.name;
}
