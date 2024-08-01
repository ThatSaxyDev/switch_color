// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'package:switch_color/my_game.dart';

class RotatingCircle extends PositionComponent with HasGameRef<MyGame> {
  RotatingCircle({
    required super.position,
    required super.size,
    this.thickness = 10,
  })  : assert(size!.x == size.y),
        super(anchor: Anchor.center);

  final double thickness;

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
}
