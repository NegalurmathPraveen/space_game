import 'dart:ffi';
import 'dart:ui' hide TextStyle;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Text extends TextComponent with HasGameRef<SpaceGame>{
  final int num;
  Text({
    required this.num,
    required super.text,
    required super.textRenderer,
    required super.position,
    required super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  });

  @override
  void update(double dt) {
    if (gameRef.list.length < num) {
      print('num:$num');
      print('list:${gameRef.list}');
        if(!gameRef.list.contains(text))
          {
            text=text;
            textRenderer=TextPaint(
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w600,
                color: Colors.amber,
              ),
            );
          }

    }
    else{
      text=text;
      textRenderer=TextPaint(
        style: const TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w600,
          color: Colors.white60,
        ),
      );
    }
    super.update(dt);
  }
}

class WordDisplay extends PositionComponent with HasGameRef<SpaceGame>{
  var list;
  late TextComponent _textComponent;
  @override
  Future<void>? onLoad()async
  {
    // print('word_display:${gameRef.list}');
    //  list=gameRef.list;
    //      // final positionX = 40 * i;
    // _textComponent=TextComponent(text:list.join(''),
    //   textRenderer: TextPaint(
    //     style: const TextStyle(
    //       fontSize: 50,
    //       fontWeight:FontWeight.w600,
    //       color: Colors.amber,
    //     ),
    //   ),
    //   position: Vector2(40+game.size.x*0.45,game.size.y*0.05),
    //   size:Vector2(gameRef.size.y * 600 / 469, gameRef.size.y) * .10,
    //   anchor: Anchor.center,
    // );
    //       add(_textComponent);

    for (var i = 0; i < gameRef.list.length; i++) {
      final positionX = 40 * i;
      _textComponent=Text(
        text: gameRef.list[i],
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.w600,
            color: Colors.white60,
          ),
        ),
        position: Vector2(positionX.toDouble()+gameRef.size.x*0.45, 20),
        size:Vector2(gameRef.size.y * 800 / 469, gameRef.size.y) * .10,
        anchor: Anchor.center, num: gameRef.list.length,
      );
      await add(
          _textComponent
      );
    }
    return super.onLoad();
  }

  @override
  void update(double dt) {
    print('list:${gameRef.list}');
    for (var i = 0; i < gameRef.list.length; i++) {
      _textComponent.text=gameRef.list[i];
      print(_textComponent.text);
    }
    super.update(dt);
  }

}