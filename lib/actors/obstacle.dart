import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:spacex/actors/player.dart';
import 'package:spacex/widgets/blast_animation.dart';

import '../main.dart';
import '../overlays/pause_button.dart';
import '../utils/audio_manager.dart';

class Obstacle extends SpriteComponent with HasGameRef<SpaceGame>,CollisionCallbacks{
  Obstacle() : super() {
    // debugMode = true;
  }
  final _random = Random();
  @override
  void onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('obstacle.png');
    size = Vector2(gameRef.size.y * 800 / 469, gameRef.size.y) * .10;
    flipHorizontallyAroundCenter();
    double yPosition = _random.nextDouble() * game.size.y;
    position = Vector2(gameRef.size.x * .95, yPosition);
    add(CircleHitbox(anchor: Anchor.center, radius: size.y * .35, position: size / 2));
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (x > 0 && !gameRef.gameOver) {
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
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    print('entered');
       if(other is Player)
       {
         if(gameRef.lives>0)
         {
           gameRef.add(BlastAnimation());
           AudioManager.playSfx('audio_life_lost.mp3');
           gameRef.lives-=1;
           removeFromParent();
           print(gameRef.lives);
         }
         else
         {
           gameRef.gameOver = true;
           AudioManager.stopBgm();
           gameRef.overlays.remove(PauseButton.ID);
           gameRef.lives=2;
         }
       }


    super.onCollisionStart(intersectionPoints, other);
  }
  @override
  void onCollisionEnd(PositionComponent other) {

    super.onCollisionEnd(other);
  }

}
