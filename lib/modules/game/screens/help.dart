import 'package:flutter/material.dart';
import 'package:wordle/modules/home/widgets/raxys_logo.dart';
import 'package:wordle/shared/widgets/letter_card.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  Widget buildExample(
    BuildContext context,
    String word,
    int letter,
    LetterState state,
    String caption,
  ) {
    final char = word[letter];
    return Column(
      children: [
        Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              for (var i = 0; i < word.length; i++)
                LetterCard(
                  text: word[i],
                  state: i == letter ? state : null,
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(caption),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.only(bottom: 76),
        children: [
          const ListTile(
            leading: Icon(Icons.auto_awesome_rounded),
            title: Text('6 алахъундлай чӏал чир ая.'),
          ),
          const ListTile(
            leading: SizedBox(
              height: double.infinity,
              child: Icon(Icons.spellcheck_rounded),
            ),
            title: Text(
              'Гьар чирунда 5 гьарф хьана кӏанда. Рукъурундал элис ракъурдайвал.',
            ),
          ),
          const ListTile(
            leading: SizedBox(
              height: double.infinity,
              child: Icon(Icons.palette_rounded),
            ),
            title: Text(
              'Гьар цӏарафдилай плиткадин ранг масакӏа жеда, гьикьван куь гиман патаг ятӏа чӏалаз.',
            ),
          ),
          ListTile(
            leading: const Icon(Icons.rule_rounded),
            title: Text(
              'Мисал',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          buildExample(
            context,
            'кӏуьд',
            4,
            LetterState.present,
            '"Д" гьарф чІала кІан тушир чкадал ала',
          ),
          buildExample(
            context,
            'кутӏа',
            2,
            LetterState.present,
            '"Т" гьарф чӏала ава, ятӏани маса чкадал.',
          ),
          buildExample(
            context,
            'сувар',
            0,
            LetterState.present,
            '"С" гьарф санани чӏала авач.',
          ),
          const ListTile(
            leading: Icon(Icons.today_rounded),
            title: Text('Цӏиий чӏал гьар юкъуз къведа.'),
          ),
        ],
      ),
    );
  }
}
