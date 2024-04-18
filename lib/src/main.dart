import 'package:flutter/material.dart';
import 'package:wordle_game/src/logic/controller.dart';
import 'package:wordle_game/src/screens/home_page.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const Wordle());
}

class Wordle extends StatelessWidget {
  const Wordle({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Controller()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wordle',
        home: const HomePage(),
      ),
    );
  }
}
