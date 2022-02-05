import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wordle/modules/help/widgets/countdown.dart';
import 'package:wordle/modules/play/utils.dart';
import 'package:wordle/shared/widgets/letter_card.dart';
import 'package:wordle/shared/widgets/rounded_back_button.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const RoundedBackButton(),
        centerTitle: true,
        title: const Text('ГьикІ къугъвада?'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => launch('https://t.me/raxysstudios'),
        icon: const Icon(Icons.send_rounded),
        label: const Text('Алакъа авун'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 76),
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
          Row(
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
          Padding(
            padding: const EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.robotoSlab(),
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
          Row(
            children: const [
              LetterCard(text: 'к'),
              LetterCard(text: 'ӏ'),
              LetterCard(
                text: 'т',
                state: LetterState.shifted,
              ),
              LetterCard(text: 'ӏ'),
              LetterCard(text: 'а'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.robotoSlab(),
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
          Row(
            children: const [
              LetterCard(text: 'с'),
              LetterCard(text: 'у'),
              LetterCard(text: 'в'),
              LetterCard(
                text: 'а',
                state: LetterState.missing,
              ),
              LetterCard(text: 'р'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.robotoSlab(),
                children: const [
                  TextSpan(
                    text: '"А"',
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
              builder: (context, duration) {
                final h = duration.inHours;
                final m = duration.inMinutes % 60;
                final s = duration.inSeconds % 60;
                return RichText(
                  text: TextSpan(
                    style: GoogleFonts.robotoSlab(),
                    children: [
                      TextSpan(
                        text: '(#${getCurrentDay() + 2}) $h : $m : $s',
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
                info = ['v' + package.version, 'b' + package.buildNumber]
                    .join(' • ');
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
