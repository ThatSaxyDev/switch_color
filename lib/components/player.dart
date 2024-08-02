import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:switch_color/components/color_switcher.dart';
import 'package:switch_color/components/ground.dart';
import 'package:switch_color/components/rotating_circles.dart';
import 'package:switch_color/components/star_component.dart';
import 'package:switch_color/my_game.dart';

class Player extends PositionComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  Player({
    required super.position,
    this.playerRadius = 12,
  }) : super(
          priority: 20,
        );
  final _velocity = Vector2.zero();
  final _gravity = 980;
  final _jumpSpeed = 450.0;

  final double playerRadius;

  Color _color = Colors.white;

  final _playerPaint = Paint();

  @override
  void onLoad() {
    super.onLoad();
    add(
      CircleHitbox(
        radius: playerRadius,
        anchor: anchor,
        collisionType: CollisionType.active,
      ),
    );
  }

  @override
  void onMount() {
    size = Vector2.all(playerRadius * 2);
    anchor = Anchor.center;
    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += _velocity * dt;

    Ground ground = gameRef.findByKeyName(Ground.keyName)!;

    if (positionOfAnchor(Anchor.bottomCenter).y > ground.position.y) {
      _velocity.setValues(0, 0);
      position = Vector2(0, ground.position.y - (height / 2));
    } else {
      _velocity.y += _gravity * dt;
    }

    _velocity.y += _gravity * dt;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // 60fps == 60 times in a second
    canvas.drawCircle(
      (size / 2).toOffset(),
      playerRadius,
      _playerPaint..color = _color,
    );
  }

  void jump() {
    _velocity.y = -_jumpSpeed;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is ColorSwitcher) {
      _color = gameRef.gameColors.random();

      other.removeFromParent();
    } else if (other is CircleArc) {
      if (_color != other.color) {
        FlameAudio.play('gameover.wav', volume: 0.5);
        gameRef.gameOver();
      }
    } else if (other is StarComponent) {
      other.showCollectEffect();
      other.removeFromParent();
      gameRef.increaseScore();
      FlameAudio.play('collect.wav');
      gameRef.checkToGenerateNextBatch(other);
    }
  }
}
