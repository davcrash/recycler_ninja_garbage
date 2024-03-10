import 'package:flutter/material.dart';
import 'package:garbage_game/src/app/credits_screen.dart';
import 'package:garbage_game/src/app/game_screen.dart';
import 'package:garbage_game/src/app/main_screen.dart';
import 'package:garbage_game/src/colors.dart' as colors;

class GameApp extends StatelessWidget {
  const GameApp({super.key});
  final buttonShape = const BeveledRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(
        7,
      ),
      bottomRight: Radius.circular(
        7,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: 'FutilePro',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(shape: buttonShape),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(shape: buttonShape),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(shape: buttonShape),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(shape: buttonShape),
        ),
        buttonTheme: ButtonThemeData(
          shape: buttonShape,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: colors.primary,
        ),
      ),
      routes: {
        '/': (context) => const MainScreen(),
        '/game': (context) => const GameScreen(),
        '/credits': (context) => const CreditsScreen(),
      },
      initialRoute: '/',
    );
  }
}
