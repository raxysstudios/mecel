import 'package:flutter/material.dart';
import 'package:mecel/models/game_state.dart';
import 'package:mecel/modules/game/utils.dart';
import 'package:mecel/shared/extensions.dart';
import 'package:mecel/shared/widgets/rounded_back_button.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/countdown.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen(
    this.game, {
    Key? key,
  }) : super(key: key);

  final GameState game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const RoundedBackButton(),
        title: Text(context.lclz('settings')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => launch('https://t.me/raxysstudios'),
        icon: const Icon(Icons.send_rounded),
        label: Text(context.lclz('contact')),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 76),
        children: [
          ListTile(
            leading: const Icon(Icons.schedule_rounded),
            title: Countdown(
              builder: (context, string) =>
                  Text('№${getCurrentDay()} — $string'),
            ),
            subtitle: Text(context.lclz('coming')),
          ),
          ListTile(
            onTap: () => launch('https://github.com/alkaitagi/mecel'),
            leading: const Icon(Icons.code_rounded),
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
          ListTile(
            onTap: () => launch('https://www.powerlanguage.co.uk/mecel/'),
            leading: const Icon(Icons.grid_view_rounded),
            title: const Text('Wordle'),
            trailing: const Icon(Icons.launch_rounded),
            subtitle: const Text('The original game.'),
          ),
        ],
      ),
    );
  }
}
