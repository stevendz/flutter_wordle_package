import 'package:wordle_game/src/widgets/stats_chart.dart';
import 'package:wordle_game/src/widgets/stats_tile.dart';
import 'package:wordle_game/src/constants/answer_stages.dart';
import 'package:wordle_game/src/data/keys_map.dart';
import 'package:wordle_game/src/utils/calculate_stats.dart';
import 'package:wordle_game/src/main.dart';
import 'package:flutter/material.dart';

class StatsBox extends StatelessWidget {
  final VoidCallback onResetGame;

  const StatsBox({super.key, required this.onResetGame});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      insetPadding: EdgeInsets.fromLTRB(size.width * 0.08, size.height * 0.12, size.width * 0.08, size.height * 0.12),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(
            alignment: Alignment.centerRight,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.clear),
          ),
          const Expanded(
            child: Text(
              'STATISTIK',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: FutureBuilder(
              future: getStats(),
              builder: (context, snapshot) {
                List<String> results = ['0', '0', '0', '0', '0'];
                if (snapshot.hasData) {
                  results = snapshot.data!;
                }
                return Row(
                  children: [
                    StatsTile(
                      heading: 'Gespielt',
                      value: int.parse(results[0]),
                    ),
                    StatsTile(heading: 'Gewonnen\n%', value: int.parse(results[2])),
                    StatsTile(heading: 'Gewinn\nstrecke', value: int.parse(results[3])),
                    StatsTile(heading: 'Max\nReihe', value: int.parse(results[4])),
                  ],
                );
              },
            ),
          ),
          const Expanded(
            flex: 8,
            child: StatsChart(),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 56,
              maxHeight: 56,
            ),
            child: FilledButton(
              onPressed: () {
                keysMap.updateAll(
                  (key, value) => value = AnswerStage.notAnswered,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Wordle()),
                );
              },
              child: const Text( 'Nochmal'),
            ),
          ),
        ],
      ),
    );
  }
}
