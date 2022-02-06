import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wordle/modules/game/utils.dart';
import 'package:wordle/shared/models/game_state.dart';
import 'package:wordle/shared/widgets/rounded_back_button.dart';

import '../widgets/countdown.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen(
    this.game, {
    Key? key,
  }) : super(key: key);

  final GameState game;

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const RoundedBackButton(),
        title: const Text('Statistics'),
        actions: [
          IconButton(
            onPressed: () => launch('https://t.me/raxysstudios'),
            icon: const Icon(Icons.send_rounded),
            tooltip: 'Алакъа авун',
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 76),
        children: [
          ListTile(
            leading: const SizedBox(
              height: double.infinity,
              child: Icon(Icons.schedule_rounded),
            ),
            title: Countdown(
              builder: (context, string) => Text(string),
            ),
            subtitle:
                Text('${getCurrentDay() + 2}-ибил чӏавалай къведай чӏал жеда.'),
          ),
          ListTile(
            onTap: () => launch('https://github.com/alkaitagi/mecel'),
            leading: const SizedBox(
              height: double.infinity,
              child: Icon(Icons.code_rounded),
            ),
            trailing: const Icon(Icons.launch_rounded),
            title: const Text('GitHub Repository'),
            subtitle: FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                var info = '...';
                final package = snapshot.data;
                if (package != null) {
                  info = 'v${package.version}'
                      ' • '
                      'b${package.buildNumber}';
                }
                return Text(info);
              },
            ),
          ),
        ],
      ),
    );
  }
}
