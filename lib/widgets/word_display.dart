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

class Word extends PositionComponent with HasGameRef<SpaceGame>{
  Word() : super(){
    //debugMode = true;
  }
  late TextComponent _textComponent;
  late TextComponent _textComponent1;
  @override
  Future<void>? onLoad()async
  {
    print('word_display:${gameRef.list}');
    _textComponent=TextComponent(text:gameRef.list.join(''),
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 50,
          fontWeight:FontWeight.w600,
          color: Colors.white54,
        ),
      ),
      position: Vector2(40+game.size.x*0.45,game.size.y*0.05),
      size:Vector2(gameRef.size.y * 600 / 469, gameRef.size.y) * .10,
      anchor: Anchor.center,
    );
    add(_textComponent);
    _textComponent1=TextComponent(text:gameRef.list1.join(''),
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 50,
          fontWeight:FontWeight.w600,
          color: Colors.amber,
        ),
      ),
      position: Vector2(game.size.x*0.435,game.size.y*0.05),
      size:Vector2(gameRef.size.y * 600 / 469, gameRef.size.y) * .10,
      anchor: Anchor.center,
    );
    add(_textComponent1);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
      _textComponent.text=gameRef.list.join('');
      _textComponent1.text=gameRef.list1.join('');
  }

}
