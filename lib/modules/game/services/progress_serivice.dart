import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>?> restoreProgress(String language, int day) async {
  final prefs = await SharedPreferences.getInstance();
  return day == prefs.getInt('$language.day')
      ? prefs.getStringList('$language.attempts')
      : null;
}

Future<void> saveProgress(
  String language,
  List<String> attempts, [
  int? day,
]) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList('$language.attempts', attempts);
  if (day != null) prefs.setInt('$language.day', day);
}
