import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wordle/modules/help/widgets/countdown.dart';
import 'package:wordle/modules/home/widgets/raxys_logo.dart';
import 'package:wordle/modules/play/utils.dart';
import 'package:wordle/shared/widgets/letter_card.dart';
import 'package:wordle/shared/widgets/rounded_back_button.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final richTextStyle = GoogleFonts.robotoSlab(
      color: Theme.of(context).textTheme.bodyText2?.color,
    );
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        // backgroundColor: Colors.transparent,
        leading: const RoundedBackButton(),
        centerTitle: true,
        title: const Text('ГьикІ къугъвада?'),
        actions: const [
          RaxysLogo(
            opacity: .1,
            scale: 7,
          ),
          SizedBox(width: 20)
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => launch('https://t.me/raxysstudios'),
        icon: const Icon(Icons.send_rounded),
        label: const Text('Алакъа авун'),
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
          const Divider(
            indent: 8,
            endIndent: 8,
          ),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text('Цӏиий чӏал гьар юкъуз къведа.'),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Countdown(
              builder: (context, string) {
                return RichText(
                  text: TextSpan(
                    style: richTextStyle,
                    children: [
                      TextSpan(
                        text: '(#${getCurrentDay() + 2}) $string',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(text: ' чӏавалай къведай чӏал жеда.'),
                    ],
                  ),
                );
              },
            ),
          ),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              var info = '...';
              final package = snapshot.data;
              if (package != null) {
                info = [
                  'v' + package.version,
                  'b' + package.buildNumber,
                ].join(' • ');
              }
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  info,
                  style: Theme.of(context).textTheme.caption,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
