import 'package:flutter/material.dart';
import 'package:garbage_game/src/app/overlay/widgets/game_over.dart';
import 'package:garbage_game/src/app/overlay/widgets/pause_menu.dart';
import 'package:garbage_game/src/app/overlay/widgets/won_level.dart';
import 'package:garbage_game/src/bloc/overlay/overlay_bloc.dart';

class OverlayScreen extends StatelessWidget {
  const OverlayScreen({
    super.key,
    required this.type,
  });

  final OverlayType type;

  Widget _getContentByType() {
    switch (type) {
      case OverlayType.wonLevel:
        return const WonLevel();
      case OverlayType.gameOver:
        return const GameOver();

      case OverlayType.paused:
      default:
        return const PauseMenu();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          type == OverlayType.caughtPower || type == OverlayType.wonLevel
              ? Colors.transparent
              : Colors.black.withOpacity(0.5),
      body: Center(
        child: _getContentByType(),
      ),
    );
  }
}
