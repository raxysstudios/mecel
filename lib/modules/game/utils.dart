import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String getTodaysWord(Set<String> words) {
  final day = getCurrentDay();
  final i = day % words.length;
  final word = words.elementAt(i);
  return word;
}

int getCurrentDay() {
  final orig = DateTime(2022, 2, 5);
  final diff = DateTime.now().difference(orig);
  return diff.inDays;
}

Future<void> copyText(BuildContext context, String? text) async {
  if (text?.isNotEmpty ?? false) {
    await Clipboard.setData(
      ClipboardData(text: text),
    );
  }
}
