import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ElapsedTime extends TextComponent with HasGameRef<SpaceGame> {
  @override
  void onLoad() async {
    await super.onLoad();
    scale = Vector2.all(2.5);
    anchor=Anchor.topLeft;
    position = Vector2(gameRef.size.x * .8, 3);
    textRenderer = TextPaint(style: const TextStyle(color: Colors.white));
  }

  @override
  void update(double dt) {
    text = 'time: ${gameRef.elapsedTime.elapsed.inSeconds}';

    super.update(dt);
  }
}
