import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:switch_color/my_game.dart';

class ColorSwitcher extends PositionComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  ColorSwitcher({
    super.position,
    this.radius = 20,
  }) : super(anchor: Anchor.center, size: Vector2.all(radius * 2));

  final double radius;

  @override
  void onLoad() {
    super.onLoad();
    add(
      CircleHitbox(
        position: size / 2,
        radius: radius,
        anchor: anchor,
        collisionType: CollisionType.passive,
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    List<Color> arcColors = gameRef.gameColors;
    const circle = pi * 2;

    final sweep = circle / arcColors.length;

    for (int i = 0; i < arcColors.length; i++) {
      canvas.drawArc(
        size.toRect(),
        i * sweep,
        sweep,
        true,
        Paint()..color = arcColors[i],
      );
    }
  }
}
