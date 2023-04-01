import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class LivesLeft extends TextComponent with HasGameRef<SpaceGame> {
  @override
  void onLoad() async {
    await super.onLoad();
    scale = Vector2.all(3);
    anchor=Anchor.topRight;
    position = Vector2(gameRef.size.x * 0.955, 8);
    textRenderer = TextPaint(style: const TextStyle(color: Colors.white));
  }

  @override
  void update(double dt) {
    text = '${int.parse(gameRef.lives.toString())+1}';

    super.update(dt);
  }
}