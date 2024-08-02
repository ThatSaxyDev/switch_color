import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/rendering.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:switch_color/components/color_switcher.dart';
import 'package:switch_color/components/ground.dart';
import 'package:switch_color/components/player.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:switch_color/components/rotating_circles.dart';
import 'package:switch_color/components/star_component.dart';

class MyGame extends FlameGame
    with TapCallbacks, HasCollisionDetection, HasDecorator, HasTimeScale {
  late Player myPlayer;

  final List<Color> gameColors;

  ValueNotifier<int> currentScore = ValueNotifier(0);

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
  Future<void> onLoad() async {
    await super.onLoad();
    decorator = PaintDecorator.blur(0);
    FlameAudio.bgm.initialize();
    await Flame.images.loadAll([
      'tapicon.png',
      'staricon.png',
    ]);
    await FlameAudio.audioCache.loadAll([
      'background.mp3',
      'collect.wav',
      'gameover.wav',
    ]);
  }

  @override
  void onMount() {
    _initializeGame();
    super.onMount();
  }

  void _initializeGame() {
    currentScore.value = 0;
    world.add(myPlayer = Player(position: Vector2(0, 350)));
    world.add(Ground(position: Vector2(0, 500)));
    camera.moveTo(Vector2.zero());
    generateGameComponents();
    // FlameAudio.bgm.play('background.mp3', volume: 0.5);
  }

  @override
  void update(double dt) {
    // debugMode = true;
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
    world.add(ColorSwitcher(
      position: Vector2(0, -520),
    ));
    world.add(
      StarComponent(
        position: Vector2(0, 100),
      ),
    );
    world.add(
      RotatingCircle(
        position: Vector2(0, 100),
        size: Vector2(200, 200),
      ),
    );
    world.add(
      StarComponent(
        position: Vector2(0, -320),
      ),
    );
    world.add(
      RotatingCircle(
        position: Vector2(0, -320),
        size: Vector2(150, 150),
      ),
    );
    world.add(
      RotatingCircle(
        position: Vector2(0, -320),
        size: Vector2(190, 190),
      ),
    );
    world.add(
      RotatingCircle(
        position: Vector2(0, -730),
        size: Vector2(200, 200),
      ),
    );
    world.add(
      StarComponent(
        position: Vector2(0, -730),
      ),
    );
  }

  void gameOver() {
    FlameAudio.bgm.stop();
    for (var element in world.children) {
      element.removeFromParent();
    }
    _initializeGame();
  }

  bool get isGamePaused => timeScale == 0.0;

  bool get isGamePlaying => !isGamePaused;

  void pauseGame() {
    (decorator as PaintDecorator).addBlur(8);
    timeScale = 0.0;
    FlameAudio.bgm.pause();
    // pauseEngine();
  }

  void resumeGame() {
    (decorator as PaintDecorator).addBlur(0);
    timeScale = 1;
    FlameAudio.bgm.resume();
    // resumeEngine();
  }

  void increaseScore() {
    currentScore.value++;
  }
}
