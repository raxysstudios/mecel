import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension TitleCase on String? {
  String get titleCase {
    final text = this;
    if (text == null) return '';
    return text
        .split(' ')
        .where((s) => s.isNotEmpty)
        .map((w) => w[0].toUpperCase() + w.substring(1))
        .join(' ')
        .split('-')
        .where((s) => s.isNotEmpty)
        .map((w) => w[0].toUpperCase() + w.substring(1))
        .join('-');
  }
}

extension Localize on BuildContext {
  String lclz(String key) {
    final map = read<Map<String, String>>();
    return map[key] ?? 'error';
  }
}
