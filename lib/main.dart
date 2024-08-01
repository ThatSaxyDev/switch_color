import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(game: MyGame()),
  );
}

class MyGame extends FlameGame {
  late Player myPlayer;

  @override
  Color backgroundColor() => const Color(0xff222222);

  @override
  void onMount() {
    add(myPlayer = Player());
    super.onMount();
  }
}

class Player extends Component {
  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);
  }
}
