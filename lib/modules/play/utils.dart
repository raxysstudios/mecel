import 'package:flutter/material.dart';

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
      icon: Icons.check_sharp,
      callback: done,
    ),
    ...layout.last,
    InputKey(
      null,
      flex: 2,
      icon: Icons.backspace_sharp,
      callback: backspace,
    ),
  ];
  return layout;
}
