import 'package:wordle_game/src//constants/answer_stages.dart';
import 'package:wordle_game/src//data/keys_map.dart';
import 'package:wordle_game/src//models/tile_model.dart';
import 'package:wordle_game/src//utils/calculate_chart_stats.dart';
import 'package:wordle_game/src//utils/calculate_stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Controller extends ChangeNotifier {
  bool checkLine = false;
  bool backOrEnterTapped = false;
  bool gameWon = false;
  bool gameCompleted = false;
  bool notEnoughLetters = false;
  String correctWord = "";
  int currentTile = 0;
  int currentRow = 0;
  List<TileModel> tilesEntered = [];

  String setCorrectWord({required String word}) => correctWord = word;

  //
  void setKeyTapped({required String value}) {
    if (value == 'ENTER') {
      backOrEnterTapped = true;
      if (currentTile == 5 * (currentRow + 1)) {
        checkWord();
      } else {
        notEnoughLetters = true;
      }
    } else if (value == 'BACK') {
      backOrEnterTapped = true;
      notEnoughLetters = false;
      if (currentTile > 5 * (currentRow + 1) - 5) {
        currentTile--;
        tilesEntered.removeLast();
      }
    } else {
      backOrEnterTapped = false;
      notEnoughLetters = false;
      if (currentTile < 5 * (currentRow + 1)) {
        tilesEntered.add(TileModel(letter: value, answerStage: AnswerStage.notAnswered));
        currentTile++;
      }
    }
    notifyListeners();
  }

  //
  void checkWord() {
    final List<String> guessed = [];
    List<String> remainingCorrect = [];
    String guessedWord = "";

    for (int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
      guessed.add(tilesEntered[i].letter);
    }

    guessedWord = guessed.join();
    remainingCorrect = correctWord.characters.toList();

    if (guessedWord == correctWord) {
      for (int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
        tilesEntered[i].answerStage = AnswerStage.correct;
        keysMap.update(tilesEntered[i].letter, (value) => AnswerStage.correct);
        gameWon = true;
        gameCompleted = true;
      }
    } else {
      for (int i = 0; i < 5; i++) {
        if (guessedWord[i] == correctWord[i]) {
          remainingCorrect.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * 5)].answerStage = AnswerStage.correct;
          keysMap.update(guessedWord[i], (value) => AnswerStage.correct);
        }
      }
      ///documentation
      //comment
      for (int i = 0; i < remainingCorrect.length; i++) {
        for (int j = 0; j < 5; j++) {
          if (remainingCorrect[i] == tilesEntered[j + (currentRow * 5)].letter) {
            if (tilesEntered[j + (currentRow * 5)].answerStage != AnswerStage.correct) {
              tilesEntered[j + (currentRow * 5)].answerStage = AnswerStage.contains;
            }

            final resultKey =
                keysMap.entries.where((element) => element.key == tilesEntered[j + (currentRow * 5)].letter);

            if (resultKey.single.value != AnswerStage.correct) {
              keysMap.update(resultKey.single.key, (value) => AnswerStage.contains);
            }
          }
        }
      }
      for (int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
        if (tilesEntered[i].answerStage == AnswerStage.notAnswered) {
          tilesEntered[i].answerStage = AnswerStage.incorrect;

          final results = keysMap.entries.where((element) => element.key == tilesEntered[i].letter);
          if (results.single.value == AnswerStage.notAnswered) {
            keysMap.update(tilesEntered[i].letter, (value) => AnswerStage.incorrect);
          }
        }
      }
    }
    checkLine = true;
    currentRow++;

    if (currentRow == 6) {
      gameCompleted = true;
    }

    if (gameCompleted) {
      calculateStats(gameWon: gameWon);
      if (gameWon) {
        setChartStats(currentRow: currentRow);
      }
    }

    notifyListeners();
  }

  void resetGame() {
    // Reset game-related variables
    gameWon = false;
    gameCompleted = false;
    currentTile = 0;
    currentRow = 0;
    tilesEntered.clear();

    // Reset keyboard-related state by calling initialKeysMap to get a fresh map
    keysMap = initialKeysMap();

    // Notify listeners to rebuild UI components that depend on these states
    notifyListeners();
  }
}
