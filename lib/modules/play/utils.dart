import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/input_key.dart';

InputLayout layoutFromStrings({
  required List<String> strings,
  required VoidCallback backspace,
  required VoidCallback done,
}) {
  final layout = strings
      .map((s) => s.characters.map((c) => InputKey(c)).toList())
      .toList();
  layout.last = [
    InputKey(
      null,
      flex: 2,
      icon: Icons.done_rounded,
      callback: done,
    ),
    ...layout.last,
    InputKey(
      null,
      flex: 2,
      icon: Icons.backspace_rounded,
      callback: backspace,
    ),
  ];
  return layout;
}

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
