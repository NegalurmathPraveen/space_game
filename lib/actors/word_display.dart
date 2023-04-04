import 'dart:ffi';
import 'dart:ui' hide TextStyle;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Text extends TextComponent with HasGameRef<SpaceGame>{
  var textNum;
  Text({
    required this.textNum,
    required super.text,
    required super.textRenderer,
    required super.position,
    required super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  });
var text1;
  @override
  void update(double dt) {
    this.text=text;
    if (textNum < gameRef.list.length) {
      print('num:$num');
      print('list:${gameRef.list}');
        if(!gameRef.list.contains(this.text))
          {
            this.text=text;
            textRenderer=TextPaint(
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w600,
                color: Colors.amber,
              ),
            );
          }
    }
    else if(textNum == num){
      text=text;
      textRenderer=TextPaint(
        style: const TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w600,
          color: Colors.white60,
        ),
      );
    }
    else if(gameRef.list.length==0)
      {
        removeFromParent();
      }
    super.update(dt);
  }
}

class WordDisplay extends PositionComponent with HasGameRef<SpaceGame>{
  var list;
  late TextComponent _textComponent;
  var text1;
  @override
  Future<void>? onLoad()async
  {
    text1=gameRef.list;
    for (var i = 0; i < gameRef.list.length; i++) {
      final positionX = 40 * i;
      await add(
          Text(
            textNum:i,
            text: text1[i],
            textRenderer: TextPaint(
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w600,
                color: Colors.white60,
              ),
            ),
            position: Vector2(positionX.toDouble()+gameRef.size.x*0.45,10),
            size:Vector2(gameRef.size.y * 800 / 469, gameRef.size.y) * .10,
            anchor: Anchor.topLeft
          )
      );
    }
    return super.onLoad();
  }

}