import 'package:flutter/material.dart';
import 'package:wordle/shared/models/language.dart';

class LanguageAvatar extends StatelessWidget {
  const LanguageAvatar(
    this.language, {
    Key? key,
  }) : super(key: key);

  final Language language;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 18,
      backgroundImage: AssetImage('assets/flags/${language.flag}.png'),
      backgroundColor: Colors.transparent,
    );
  }
}
