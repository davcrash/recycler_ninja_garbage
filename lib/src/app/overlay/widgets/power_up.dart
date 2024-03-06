import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_game/src/bloc/overlay/overlay_bloc.dart';
import 'package:garbage_game/src/colors.dart' as colors;
import 'package:garbage_game/src/models/power_up_type.dart';

class PowerUpAnimation extends StatefulWidget {
  const PowerUpAnimation({
    super.key,
    this.powerUpType,
  });
  final PowerUpType? powerUpType;

  @override
  State<PowerUpAnimation> createState() => _PowerUpAnimationState();
}

class _PowerUpAnimationState extends State<PowerUpAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _animation = Tween<double>(begin: 0.5, end: 100.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
        reverseCurve: Curves.ease,
      ),
    );
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.duration = const Duration(milliseconds: 100);
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        context.read<OverlayBloc>().hide();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getTextByType() {
    switch (widget.powerUpType) {
      case PowerUpType.bigGun:
        return "+Shuriken";
      case PowerUpType.bounceBullet:
        return "+Bounce Ball";
      case PowerUpType.heal:
        return "+Heal";
      case PowerUpType.nuclearBomb:
        return "Nuclear Bomb";
      case PowerUpType.machineGun:
      default:
        return "+Kunai Speed";
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseTheme = Theme.of(context);
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PowerUpImage(powerUpType: widget.powerUpType),
          Padding(
            padding: const EdgeInsets.only(top: .2),
            child: Text(
              _getTextByType(),
              textAlign: TextAlign.center,
              style: baseTheme.textTheme.bodySmall?.copyWith(
                fontSize: 0.2,
                color: colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PowerUpImage extends StatelessWidget {
  const PowerUpImage({
    super.key,
    this.powerUpType,
  });
  final PowerUpType? powerUpType;
  final double height = 1.2;
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
