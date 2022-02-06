import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordle/modules/home/widgets/raxys_logo.dart';
import 'package:wordle/shared/widgets/letter_card.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final richTextStyle = GoogleFonts.robotoSlab(
      color: Theme.of(context).textTheme.bodyText2?.color,
    );
    return Scaffold(
      appBar: AppBar(
        leading: Stack(
          alignment: Alignment.center,
          children: const [
            RaxysLogo(
              opacity: .1,
              scale: 7,
            ),
          ],
        ),
        title: const Text('ГьикІ къугъвада?'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.play_arrow_rounded),
        label: const Text('Play'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 76),
        children: [
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              '6 алахъундлай чӏал чир ая.\n\nГьар чирунда 5 гьарф хьана кӏанда. Рукъурундал элис ракъурдайвал.\n\nГьар цӏарафдилай плиткадин ранг масакӏа жеда, гьикьван куь гиман патаг ятӏа чӏалаз.',
            ),
          ),
          const Divider(
            indent: 8,
            endIndent: 8,
          ),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text('Мисал:'),
          ),
          SizedBox(
            height: 64,
            child: Row(
              children: const [
                LetterCard(text: 'к'),
                LetterCard(text: 'ӏ'),
                LetterCard(text: 'у'),
                LetterCard(text: 'ь'),
                LetterCard(
                  text: 'д',
                  state: LetterState.present,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(
                style: richTextStyle,
                children: const [
                  TextSpan(
                    text: '"Д"',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' гьарф чІала кІан тушир чкадал ала'),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 64,
            child: Row(
              children: const [
                LetterCard(text: 'к'),
                LetterCard(text: 'у'),
                LetterCard(
                  text: 'т',
                  state: LetterState.shifted,
                ),
                LetterCard(text: 'ӏ'),
                LetterCard(text: 'а'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(
                style: richTextStyle,
                children: const [
                  TextSpan(
                    text: '"Т"',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' гьарф чӏала ава, ятӏани маса чкадал.'),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 64,
            child: Row(
              children: const [
                LetterCard(
                  text: 'с',
                  state: LetterState.missing,
                ),
                LetterCard(text: 'у'),
                LetterCard(text: 'в'),
                LetterCard(text: 'а'),
                LetterCard(text: 'р'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(
                style: richTextStyle,
                children: const [
                  TextSpan(
                    text: '"С"',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' гьарф санани чӏала авач.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
