import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/services.dart';
import 'package:spacex/screens/game_play_screen.dart';

import '../main.dart';

class Heart extends SpriteAnimationComponent
    with HasGameRef<SpaceGame>{

  @override
  void onLoad() async {
    await super.onLoad();
    var heart = SpriteComponent(sprite: await gameRef.loadSprite(
        'life.png', srcSize: Vector2(100, 100))
    );
    anchor=Anchor.topRight;
    position = Vector2(gameRef.size.x *0.9,gameRef.size.y*0.007);
    scale = Vector2.all(0.8);
    //position = Vector2(gameRef.size.x * 0.05, gameRef.size.x * 0.09);
    add(heart);
  }
}
