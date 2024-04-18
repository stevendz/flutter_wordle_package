import 'dart:math';

import 'package:wordle_game/src//constants/words.dart';
import 'package:wordle_game/src//logic/controller.dart';
import 'package:wordle_game/src//screens/settings.dart';
import 'package:wordle_game/src//utils/quick_box.dart';
import 'package:wordle_game/src//widgets/grid.dart';
import 'package:wordle_game/src//widgets/intro_box.dart';
import 'package:wordle_game/src//widgets/keyboard_row.dart';
import 'package:wordle_game/src//widgets/stats_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _word;

  @override
  void initState() {
    super.initState();
    final r = Random().nextInt(words.length);
    _word = words[r];

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final controller = Provider.of<Controller>(context, listen: false);
      controller.setCorrectWord(word: _word);
      controller.resetGame();

      // Check if it's the first launch
      final prefs = await SharedPreferences.getInstance();
      final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

      if (isFirstLaunch) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) => const IntroBox(),
          );
          await prefs.setBool('isFirstLaunch', false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordle'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Consumer<Controller>(
            builder: (_, notifier, __) {
              if (notifier.notEnoughLetters) {
                runQuickBox(context: context, message: 'Nicht genug Buchstaben');
              }
              if (notifier.gameCompleted) {
                if (notifier.gameWon) {
                  if (notifier.currentRow == 6) {
                    runQuickBox(context: context, message: 'Super!');
                  } else {
                    runQuickBox(context: context, message: 'Genial!');
                  }
                } else {
                  runQuickBox(context: context, message: notifier.correctWord);
                }
                Future.delayed(
                  const Duration(milliseconds: 4000),
                  () {
                    if (mounted) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Builder(
                            builder: (BuildContext innerContext) {
                              return StatsBox(
                                onResetGame: () {
                                  Provider.of<Controller>(innerContext, listen: false).resetGame();
                                  Navigator.of(innerContext).pop();
                                },
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                );
              }

              return IconButton(
                onPressed: () {
                  // Retrieve the controller instance here
                  final controller = Provider.of<Controller>(context, listen: false);

                  // Show the StatsBox dialog with a callback provided
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => StatsBox(
                      onResetGame: () {
                        controller.resetGame();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                          (route) => false,
                        );
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.bar_chart_outlined),
              );
            },
          ),
          IconButton(
            onPressed: () {
              showDialog(context: context, builder: (BuildContext context) => const IntroBox());
            },
            icon: const Icon(Icons.info_outline),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Settings()));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: const Column(
        children: [
          Divider(
            height: 1,
            thickness: 2,
          ),
          Expanded(flex: 7, child: Grid()),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                KeyboardRow(
                  min: 1,
                  max: 10,
                ),
                KeyboardRow(
                  min: 11,
                  max: 19,
                ),
                KeyboardRow(
                  min: 20,
                  max: 29,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
