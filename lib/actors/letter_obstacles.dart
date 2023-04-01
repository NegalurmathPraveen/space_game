import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:spacex/actors/player.dart';

import '../main.dart';
import '../overlays/pause_button.dart';

class LetterObstacles extends SpriteAnimationComponent with HasGameRef<SpaceGame>,CollisionCallbacks{
  LetterObstacles() : super() {
    // debugMode = true;
  }
  final _random = Random();
  @override
  void onLoad() async {
    await super.onLoad();
    //sprite = await gameRef.loadSprite();
    var alphabets = SpriteComponent(sprite: await gameRef.loadSprite(
        'alphabets.png', srcSize: Vector2(100, 100)),
        position: gameRef.size / 2,
        anchor: Anchor.centerRight
    );
    size = Vector2(gameRef.size.y * 800 / 469, gameRef.size.y) * .10;
    double yPosition = _random.nextDouble() * game.size.y;
    position = Vector2(gameRef.size.x * .95, yPosition);
   // add(alphabets);
   // add(RectangleHitbox.relative(Vector2(.08,.18), parentSize: gameRef.size,position:gameRef.size/2.5));
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

}
