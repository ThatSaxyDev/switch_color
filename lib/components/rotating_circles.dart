import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class RotatingCircle extends PositionComponent {
  RotatingCircle({
    required super.position,
    required super.size,
    this.thickness = 10,
  })  : assert(size!.x == size.y),
        super(anchor: Anchor.center);

  final double thickness;

  @override
  void render(Canvas canvas) {
    final radius = (size.x / 2) - (thickness / 2);
    canvas.drawCircle(
      (size / 2).toOffset(),
      radius,
      Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = thickness,
    );
  }
}
