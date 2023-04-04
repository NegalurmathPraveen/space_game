import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:spacex/actors/player.dart';

import '../main.dart';
import '../overlays/pause_button.dart';
import '../utils/audio_manager.dart';

class WordLetters extends PositionComponent with HasGameRef<SpaceGame>,CollisionCallbacks {
  WordLetters() : super() {
    //debugMode = true;
  }

  final _random = Random();
  var text = 'A';
  int i = 0;
  late TextComponent _scoreTextComponent;

  @override
  Future<void>? onLoad() async
  {
    _scoreTextComponent = TextComponent(text: '${gameRef.list.elementAt(0)}',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.w600,
          color: Colors.lightGreenAccent,
        ),
      ),
      size: Vector2(gameRef.size.y * 800 / 469, gameRef.size.y) * .10,
      anchor: Anchor.center,
    );
    double yPosition = _random.nextDouble() * game.size.y;
    position = Vector2(gameRef.size.x * .95, yPosition-50);
    add(_scoreTextComponent);
    add(RectangleHitbox.relative(Vector2(0.4, 1), anchor: Anchor.center,
        parentSize: Vector2(gameRef.size.y * 800 / 469, gameRef.size.y) * .10,
        position: gameRef.letterObstacles.position));
    //_scoreTextComponent.text = gameRef.list.elementAt(0);
    print(gameRef.list);
    return super.onLoad();
  }


  @override
  void update(double dt) {
    super.update(dt);
    position.clamp(Vector2.zero()+size/2, gameRef.size-size/2);
    if (x > 0 && !gameRef.success) {
      //_scoreTextComponent.text='D';
      x = x - 100 * dt;
    } else {
      removeFromParent();
    }

    if (gameRef.elapsedTime.elapsed.inSeconds > 30 && x > gameRef.player.x) {
      if (gameRef.player.y > y) {
        y += 3 * dt;
      } else {
        y -= 3 * dt;
      }
    }
  }


  @override
  void onCollisionStart(Set<Vector2> intersectionPoints,
      PositionComponent other) {
    if(other is Player)
    {
      removeFromParent();
      if(_scoreTextComponent.text==gameRef.list[0])
      {
        gameRef.list.removeAt(0);
        gameRef.removeFromParent();
        if(gameRef.list.length==0)
          {
            gameRef.success = true;
            AudioManager.stopBgm();
            gameRef.overlays.remove(PauseButton.ID);
            gameRef.lives=3;
          }
      }
    }
  }
}