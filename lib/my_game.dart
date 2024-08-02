import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:switch_color/components/color_switcher.dart';
import 'package:switch_color/components/ground.dart';
import 'package:switch_color/components/player.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:switch_color/components/rotating_circles.dart';

class MyGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  late Player myPlayer;

  final List<Color> gameColors;

  MyGame({
    this.gameColors = const [
      Colors.redAccent,
      Colors.greenAccent,
      Colors.blueAccent,
      Colors.yellowAccent,
    ],
  }) : super(
          camera: CameraComponent.withFixedResolution(
            width: 600,
            height: 1200,
          ),
        );

  @override
  Color backgroundColor() => const Color(0xff222222);

  @override
  void onMount() {
    world.add(myPlayer = Player(position: Vector2(0, 350)));
    world.add(Ground(position: Vector2(0, 500)));
    generateGameComponents();

    super.onMount();
  }

  @override
  void update(double dt) {
    debugMode = true;
    final cameraY = camera.viewfinder.position.y;
    final playerY = myPlayer.position.y;

    if (playerY < cameraY) {
      camera.viewfinder.position = Vector2(0, playerY);
    }
    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    myPlayer.jump();
    super.onTapDown(event);
  }

  void generateGameComponents() {
    world.add(ColorSwitcher(
      position: Vector2(0, 310),
    ));
    world.add(ColorSwitcher(
      position: Vector2(0, -120),
    ));
    world.add(
      RotatingCircle(
        position: Vector2(0, 100),
        size: Vector2(200, 200),
      ),
    );
    world.add(
      RotatingCircle(
        position: Vector2(0, -320),
        size: Vector2(200, 200),
      ),
    );
  }
}
