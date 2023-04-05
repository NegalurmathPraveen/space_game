import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/services.dart';
import 'package:spacex/actors/letter_obstacles.dart';
import 'package:spacex/actors/obstacle.dart';
import 'package:spacex/screens/game_play_screen.dart';

import '../main.dart';
import '../overlays/pause_button.dart';
import '../utils/audio_manager.dart';
import '../widgets/blast_animation.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<SpaceGame>,CollisionCallbacks{
  Player() : super() {
     //debugMode = true;
  }
  late CollisionType collisionType;
  @override
  void onLoad() async {
    await super.onLoad();
   collisionType=CollisionType.active;
    var player = SpriteComponent(sprite: await gameRef.loadSprite(
        'player.png', srcSize: Vector2(100, 100)),
        position: gameRef.size/5,
        anchor: Anchor.center
    );
    add(player);

    add(RectangleHitbox.relative(Vector2(.42,.42),anchor: Anchor.center,parentSize: gameRef.size/5,position:gameRef.size/5));
    add(PolygonHitbox.relative([Vector2(.2,0),Vector2(-0.2,-.8),Vector2(-0.2,.8)],anchor: Anchor.center,parentSize: gameRef.size/5,position:gameRef.size/5 ));
  }

  void hit() {
    add(
      OpacityEffect.fadeOut(
        EffectController(
          alternate: true,
          duration: 0.1,
          repeatCount: 5,
        ),
      )..onComplete = () {
        add(gameRef.player);
      },
    );
  }
  @override
  void update(double dt) {
    super.update(dt);
     if (y > gameRef.size.y && y < 0 && !gameRef.showingGameOverScreen ) {
      gameRef.gameOver = true;
    }
     else if(y > gameRef.size.y && y < 0 && !gameRef.showingSuccessScreen)
       {
         gameRef.success=true;
       }
      position=Vector2(0,gameRef.pointerCurrentPosition!.y)-Vector2(0,gameRef.pointerStartPosition!.y);
      position.clamp(Vector2.zero()+this.size/2, gameRef.size-this.size/2);
  }
  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    print('entered');
    if(other is Obstacle || other is LetterObstacles )
    {
      if(gameRef.lives>1)
      {
        AudioManager.playSfx('audio_life_lost.mp3');
        gameRef.lives-=1;
        //removeFromParent();
        print(gameRef.lives);
      }
      else
      {
        gameRef.gameOver = true;
        AudioManager.stopBgm();
        gameRef.overlays.remove(PauseButton.ID);
        gameRef.lives=3;
      }
    }



    super.onCollisionStart(intersectionPoints, other);
  }
}
