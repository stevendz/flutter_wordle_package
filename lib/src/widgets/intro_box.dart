import 'package:wordle_game/src//constants/colors.dart';
import 'package:flutter/material.dart';

enum LetterStatus { correct, misplaced, absent }

class IntroBox extends StatelessWidget {
  const IntroBox({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      insetPadding: EdgeInsets.fromLTRB(
        size.width * 0.08,
        size.height * 0.12,
        size.width * 0.08,
        size.height * 0.12,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconButton(
              alignment: Alignment.topRight,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
            ),
            Text(
              'So funktioniert es',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.02),
            const Text(
              'Erraten Sie das Wort in 6 Versuchen.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: size.height * 0.01),
            const Text(
              '• Jedes Wort besteht aus 5 Buchstaben.',
              style: TextStyle(fontSize: 14),
            ),
            const Text(
              '• Die Farben der Kästen ändert sich basierend auf wie nahe Sie dem Wort gekommen sind.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: size.height * 0.04),
            Text(
              'Beispiele',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: size.height * 0.02),
            buildExample(
              'APFEL',
              'A ist im Wort an der richtigen Stelle.',
              [LetterStatus.correct, null, null, null, null],
            ),
            SizedBox(height: size.height * 0.02),
            buildExample(
              'BRIEF',
              'R ist im Wort, doch an der falschen Stelle.',
              [null, LetterStatus.misplaced, null, null, null],
            ),
            SizedBox(height: size.height * 0.02),
            buildExample(
              'HAFEN',
              'E ist nicht im Wort an keiner Stelle.',
              [null, null, null, LetterStatus.absent, null],
            ),
            SizedBox(height: size.height * 0.04),
            const Text(
              'Wir wünschen viel Spaß beim Rätseln.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: size.height * 0.04),
          ],
        ),
      ),
    );
  }

  Widget buildExample(
    String word,
    String explanation,
    List<LetterStatus?> stages,
  ) {
    return Row(
      children: [
        for (int i = 0; i < word.length; i++)
          Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.symmetric(horizontal: 2),
            color: _getColorForStage(stages[i]),
            child: Text(
              word[i],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            explanation,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  Color _getColorForStage(LetterStatus? status) {
    switch (status) {
      case LetterStatus.correct:
        return correctGreen;
      case LetterStatus.misplaced:
        return containsYellow;
      case LetterStatus.absent:
        return Colors.grey;
      default:
        return Colors.transparent;
    }
  }
}
