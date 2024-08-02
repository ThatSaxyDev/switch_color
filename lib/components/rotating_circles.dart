// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import 'package:switch_color/my_game.dart';

class RotatingCircle extends PositionComponent with HasGameRef<MyGame> {
  RotatingCircle({
    required super.position,
    required super.size,
    this.thickness = 10,
    this.rotationSpeed = 2,
  })  : assert(size!.x == size.y),
        super(anchor: Anchor.center);

  final double thickness;
  final double rotationSpeed;

  @override
  void onLoad() {
    super.onLoad();

    List<Color> arcColors = gameRef.gameColors;

    const circle = pi * 2;

    final sweep = circle / arcColors.length;

    for (int i = 0; i < arcColors.length; i++) {
      add(
        CircleArc(
          color: arcColors[i],
          startAngle: i * sweep,
          sweepAngle: sweep,
        ),
      );
    }

    add(
      RotateEffect.to(
        circle,
        EffectController(
          speed: rotationSpeed,
          infinite: true,
        ),
      ),
    );
  }
}

class CircleArc extends PositionComponent with ParentIsA<RotatingCircle> {
  final Color color;
  final double startAngle;
  final double sweepAngle;
  CircleArc({
    required this.color,
    required this.startAngle,
    required this.sweepAngle,
  }) : super(anchor: Anchor.center);

  @override
  void onMount() {
    size = parent.size;
    position = size / 2;

    _addHitbox();
    super.onMount();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawArc(
      size.toRect().deflate(parent.thickness / 2),
      startAngle,
      sweepAngle,
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = parent.thickness,
    );
  }

  void _addHitbox() {
    final center = size / 2;

    const precision = 8;

    final segment = sweepAngle / (precision - 1);
    final radius = size.x / 2;

    List<Vector2> vertices = [];

    for (int i = 0; i < precision; i++) {
      final thisSegment = startAngle + segment * i;
      vertices
          .add(center + Vector2(cos(thisSegment), sin(thisSegment)) * radius);
    }

    for (int i = precision - 1; i > 0; i--) {
      final thisSegment = startAngle + segment * i;
      vertices.add(center +
          Vector2(cos(thisSegment), sin(thisSegment)) *
              (radius - parent.thickness));
    }

    add(PolygonHitbox(
      vertices,
      collisionType: CollisionType.passive,
    ));
  }
}
