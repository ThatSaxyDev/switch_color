import 'package:flame/components.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';

class Ground extends PositionComponent {
  static const String keyName = 'single_ground_key';

  Ground({required super.position})
      : super(
          size: Vector2(200, 2),
          anchor: Anchor.center,
          key: ComponentKey.named(keyName),
        );

  late Sprite fingerSprite;

  @override
  Future<void> onMount() async {
    super.onMount();
    fingerSprite = await Sprite.load('tapicon.png');
    decorator.addLast(PaintDecorator.tint(Colors.white));
  }

  @override
  void render(Canvas canvas) {
    fingerSprite.render(
      canvas,
      position: Vector2(56, 0),
      size: Vector2(100, 100),
    );
  }
}
