import 'package:flutter/material.dart';

typedef InputLayout = List<List<InputKey>>;

class InputKey {
  InputKey(
    this.text, {
    this.flex = 1,
    this.icon,
    this.callback,
  });

  final int flex;
  final String? text;
  final IconData? icon;
  final VoidCallback? callback;
}
