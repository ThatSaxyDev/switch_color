import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent {
  final _velocity = Vector2(0, 40.0);
  final _gravity = 980;
  final _jumpSpeed = 350.0;

  @override
  void onMount() {
    position = Vector2(150, 100);
    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += _velocity * dt;
    _velocity.y += _gravity * dt;

    if (position.y == 200) {
      jump();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // 60fps == 60 times in a second
    canvas.drawCircle(
      position.toOffset(),
      15,
      Paint()..color = Colors.red,
    );
  }

  void jump() {
    _velocity.y = -_jumpSpeed;
  }
}
