import 'package:wordle/shared/models/language.dart';

const lezgi = Language(
  name: 'lezgi',
  words: [
    'сувар',
    'кӏеви',
    'мекьи',
    'юцӏак',
    'бицӏи',
    'аскӏа',
    'михьи',
    'кӏани',
    'цӏийи',
    'лахъу',
    'кӏуьд',
    'йифен',
    'салан',
    'чирун',
    'кӏили',
    'кьуьд',
    'гугун',
    'артух',
    'жуван',
    'запун',
    'ругул',
    'ягъун',
    'кутӏа',
    'кьулу',
  ],
  layout: [
    'йцукенгшз',
    'хӏъфывапр',
    'олджэячсм',
    'итьбю',
  ],
);

String getRandomWord(List<String> words) {
  final orig = DateTime(1917, 5, 1);
  final diff = DateTime.now().difference(orig);
  final i = diff.inDays % words.length;
  return words[i];
}
