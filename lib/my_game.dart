import 'package:flutter/material.dart';
import 'package:switch_color/player.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class MyGame extends FlameGame with TapCallbacks {
  late Player myPlayer;

  @override
  Color backgroundColor() => const Color(0xff222222);

  @override
  void onMount() {
    add(myPlayer = Player());
    super.onMount();
  }

  @override
  void onTapDown(TapDownEvent event) {
    myPlayer.jump();
    super.onTapDown(event);
  }
}