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

class LetterObstacles extends PositionComponent with HasGameRef<SpaceGame>,CollisionCallbacks{
  LetterObstacles() : super(){
     //debugMode = true;
  }
  final _random = Random();
  var text='A';
  var list=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
  late TextComponent _scoreTextComponent;
  var num=1;
  int i=0;
 @override
 Future<void>? onLoad()async
 {
   gameRef.list.forEach((element1) {
     var index=list.indexOf(element1);
     list.removeAt(index);
   });
   print(list);
   _scoreTextComponent=TextComponent(text: '$text',
     textRenderer: TextPaint(
       style: const TextStyle(
         fontSize: 45,
         fontWeight: FontWeight.w600,
         color: Colors.lightGreenAccent,
       ),
     ),
     size:Vector2(gameRef.size.y * 800 / 469, gameRef.size.y) * .10,
     anchor: Anchor.center,
   );
   double yPosition = _random.nextDouble() * (game.size.y-50);
   position= Vector2(gameRef.size.x * .95, yPosition);
   position.clamp(Vector2.zero()+size/2, gameRef.size-size/2);
   add(_scoreTextComponent);
   add(RectangleHitbox.relative(Vector2(0.4,1),anchor: Anchor.center,parentSize:Vector2(gameRef.size.y * 800 / 469, gameRef.size.y) * .10,position:gameRef.letterObstacles.position));

       _scoreTextComponent.text=list.elementAt(_random.nextInt(list.length));
      // _scoreTextComponent.text=wordList[i];


   return super.onLoad();
 }

  @override
  void update(double dt) {
    super.update(dt);
    if (x > 0 && !gameRef.gameOver) {
      //_scoreTextComponent.text='D';
      x = x - 100 * dt;
    } else {
      removeFromParent();
    }

    if (gameRef.elapsedTime.elapsed.inSeconds > 30 && x > gameRef.player.x) {
      if (gameRef.player.y > y) {
       // _scoreTextComponent.text='B';
        y += 3 * dt;
      } else {
       // _scoreTextComponent.text='C';
        y -= 3 * dt;
      }
    }
  }


  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    print('entered');
    if(other is Player)
      {
        removeFromParent();
      }
  }
}
