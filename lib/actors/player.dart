import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/services.dart';
import 'package:spacex/screens/game_play_screen.dart';

import '../main.dart';

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
        position: gameRef.size / 2,
        anchor: Anchor.centerRight
    );
    add(player);

    add(RectangleHitbox.relative(Vector2(.08,.18), parentSize: gameRef.size,position:gameRef.size/2.5));
  }

  void hit()
  {
    add(OpacityEffect.fadeOut(
        EffectController(
          alternate: true,
          duration: 0.2,
          repeatCount: 5,)
    )
    );
  }
  @override
  void update(double dt) {
    super.update(dt);
     if (y > gameRef.size.y && y < 0 && !gameRef.showingGameOverScreen) {
      gameRef.gameOver = true;
    }
      position=Vector2(0,gameRef.pointerCurrentPosition!.y)-Vector2(0,gameRef.pointerStartPosition!.y);

  }
  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is ScreenHitbox) {
      gameRef.gameOver = true;
    }
    super.onCollisionEnd(other);
  }
}
