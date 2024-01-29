import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:garbage_game/src/game.dart' as g_game;

void main() {
  final game = g_game.Game();
  runApp(GameWidget(game: game));
}
