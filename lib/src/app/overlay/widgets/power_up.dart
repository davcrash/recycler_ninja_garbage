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
          const FlutterLogo(size: 1),
          Padding(
            padding: const EdgeInsets.only(top: .2),
            child: Text(
              //TODO: poner nombre a los poderes
              widget.powerUpType.toString(),
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
