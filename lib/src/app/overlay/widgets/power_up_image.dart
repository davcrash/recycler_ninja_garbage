import 'package:flutter/material.dart';
import 'package:garbage_game/src/models/power_up_type.dart';

class PowerUpImage extends StatelessWidget {
  const PowerUpImage({
    super.key,
    this.powerUpType,
    this.height = 1.2,
  });
  final PowerUpType? powerUpType;
  final double? height;

  @override
  Widget build(BuildContext context) {
    switch (powerUpType) {
      case PowerUpType.bigGun:
        return Image.asset(
          'assets/images/sprites/shuriken.png',
          height: height,
        );
      case PowerUpType.bounceBullet:
        return Image.asset(
          'assets/images/sprites/ball.png',
          height: height,
        );
      case PowerUpType.heal:
        return Image.asset(
          'assets/images/sprites/heart.png',
          height: height,
        );
      case PowerUpType.nuclearBomb:
        return Image.asset(
          'assets/images/sprites/bomb.png',
          height: height,
        );
      case PowerUpType.machineGun:
      default:
        return Image.asset(
          'assets/images/sprites/kunai.png',
          height: height,
        );
    }
  }
}
