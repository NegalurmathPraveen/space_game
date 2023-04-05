import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:spacex/main.dart';


import 'package:flame/components.dart';

import '../gui/elapsed_time.dart';

enum HeartState {
  available,
  unavailable,
}

class HeartHealthComponent extends SpriteGroupComponent<HeartState>
    with HasGameRef<SpaceGame> {
  final int heartNumber;

  HeartHealthComponent({
    required this.heartNumber,
    required super.position,
    required super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final availableSprite = await game.loadSprite(
      'life.png',
      srcSize: Vector2(100, 100),
    );
    anchor=Anchor.center;

    sprites = {
      HeartState.available: availableSprite,
    };

    current = HeartState.available;
  }

  @override
  void update(double dt) {
    if (gameRef.lives < heartNumber) {
      current = HeartState.unavailable;
    } else {
      current = HeartState.available;
    }
    super.update(dt);
  }
}

class Hud extends PositionComponent with HasGameRef<SpaceGame> {
  Hud({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority = 5,
  }) {
    positionType = PositionType.viewport;
  }


  @override
  Future<void>? onLoad() async {
    add(ElapsedTime());
    for (var i = 1; i <= gameRef.lives; i++) {
      final positionX = 40 * i;
      await add(
        HeartHealthComponent(
          heartNumber: i,
          position: Vector2(positionX.toDouble(),gameRef.size.y*0.07),
          size: Vector2.all(32),
          anchor: Anchor.topLeft
        ),
      );
    }

    return super.onLoad();
  }

}