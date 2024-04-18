import 'package:wordle_game/src/constants/answer_stages.dart';
import 'package:wordle_game/src/constants/colors.dart';
import 'package:wordle_game/src/data/keys_map.dart';
import 'package:wordle_game/src/logic/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeyboardRow extends StatelessWidget {
  const KeyboardRow({
    required this.min,
    required this.max,
    super.key,
  });

  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<Controller>(
      builder: (_, notifier, __) {
        int index = 0;
        return IgnorePointer(
          ignoring: notifier.gameCompleted,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: keysMap.entries.map((e) {
              index++;
              if (index >= min && index <= max) {
                Color color = Theme.of(context).cardColor;
                Color keyColor = Colors.white;
                if (e.value == AnswerStage.correct) {
                  color = correctGreen;
                } else if (e.value == AnswerStage.contains) {
                  color = containsYellow;
                } else if (e.value == AnswerStage.incorrect) {
                  color = Colors.grey;
                } else {
                  keyColor = Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;
                }

                return Padding(
                  padding: EdgeInsets.all(size.width * 0.004),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: SizedBox(
                      width: e.key == 'ENTER' || e.key == 'BACK' ? size.width * 0.15 : size.width * 0.085,
                      height: size.height * 0.080,
                      child: Material(
                        color: color,
                        child: InkWell(
                          onTap: () {
                            Provider.of<Controller>(context, listen: false).setKeyTapped(value: e.key);
                          },
                          child: Center(
                            child: e.key == 'BACK'
                                ? const Icon(Icons.backspace_outlined)
                                : Text(
                                    e.key,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: keyColor,
                                        ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            }).toList(),
          ),
        );
      },
    );
  }
}
