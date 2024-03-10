import 'package:flame/components.dart';
import 'package:flame/widgets.dart';
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
        return SizedBox(
          height: height,
          width: height,
          child: SpriteWidget.asset(
            path: 'sprites/shuriken_overlay.png',
            srcPosition: Vector2.all(0),
            srcSize: Vector2.all(30),
          ),
        );
      case PowerUpType.bounceBullet:
        return SizedBox(
          height: height,
          width: height,
          child: SpriteWidget.asset(
            path: 'sprites/ball.png',
            srcPosition: Vector2.all(0),
            srcSize: Vector2.all(30),
          ),
        );
      case PowerUpType.heal:
        return SizedBox(
          height: height,
          width: height,
          child: SpriteWidget.asset(
            path: 'sprites/heart.png',
            srcPosition: Vector2.all(0),
            srcSize: Vector2.all(30),
          ),
        );
      case PowerUpType.nuclearBomb:
        return SizedBox(
          height: height,
          width: height,
          child: SpriteWidget.asset(
            path: 'sprites/bomb.png',
            srcPosition: Vector2.all(0),
            srcSize: Vector2.all(30),
          ),
        );
      case PowerUpType.machineGun:
      default:
        return Image.asset(
          'assets/images/sprites/kunai.png',
          height: height,
        );
      /* final newWidth = height! * 34.0 / 12.0;
        return Container(
          alignment: Alignment.center,
          height: height,
          width: newWidth,
          child: SpriteWidget.asset(
            path: 'sprites/kunai.png',
            srcSize: Vector2(12.0, 34.0),
            srcPosition: Vector2.all(0),
          ),
        ); */
    }
  }
}
