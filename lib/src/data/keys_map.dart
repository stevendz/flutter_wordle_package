import 'package:wordle_game/src/constants/answer_stages.dart';

Map<String, AnswerStage> initialKeysMap() {
  return {
    'Q': AnswerStage.notAnswered,
    'W': AnswerStage.notAnswered,
    'E': AnswerStage.notAnswered,
    'R': AnswerStage.notAnswered,
    'T': AnswerStage.notAnswered,
    'Y': AnswerStage.notAnswered,
    'U': AnswerStage.notAnswered,
    'I': AnswerStage.notAnswered,
    'O': AnswerStage.notAnswered,
    'P': AnswerStage.notAnswered,
    'A': AnswerStage.notAnswered,
    'S': AnswerStage.notAnswered,
    'D': AnswerStage.notAnswered,
    'F': AnswerStage.notAnswered,
    'G': AnswerStage.notAnswered,
    'H': AnswerStage.notAnswered,
    'J': AnswerStage.notAnswered,
    'K': AnswerStage.notAnswered,
    'L': AnswerStage.notAnswered,
    'BACK': AnswerStage.notAnswered,
    'Z': AnswerStage.notAnswered,
    'X': AnswerStage.notAnswered,
    'C': AnswerStage.notAnswered,
    'V': AnswerStage.notAnswered,
    'B': AnswerStage.notAnswered,
    'N': AnswerStage.notAnswered,
    'M': AnswerStage.notAnswered,
    'ENTER': AnswerStage.notAnswered,
  };
}

// Initialize keysMap with the function call
Map<String, AnswerStage> keysMap = initialKeysMap();
