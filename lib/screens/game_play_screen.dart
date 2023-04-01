
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/parallax.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:spacex/actors/letter_obstacles.dart';


import '../actors/obstacle.dart';
import '../gui/elapsed_time.dart';
import '../gui/lifeLeft.dart';
import '../main.dart';
import '../utils/audio_manager.dart';

class GamePlayScreen extends Component with HasGameRef<SpaceGame>, TapCallbacks {
  Timer interval = Timer(6, repeat: true);

  @override
  void onLoad() async {
    await super.onLoad();
    gameRef.elapsedTime.start();
    ParallaxComponent mountainBackground =  await ParallaxComponent.load(
      [ ParallaxImageData('background.png')],fill:LayerFill.height,
      repeat: ImageRepeat.repeat,
      baseVelocity: Vector2(50, 0),
      velocityMultiplierDelta: Vector2(1.6, 1.0),
    );
    add(mountainBackground);

    add(gameRef.player);
    add(gameRef.heart);
    add(gameRef.letterObstacles);
    addShips();
    add(ElapsedTime());
    add(LivesLeft());
  }

  void addShips() {
    interval.onTick = () {
      double elapsedSeconds = gameRef.elapsedTime.elapsed.inSeconds.toDouble();

      void addShipAtSecond(int secondToAdd) {
        Future.delayed(Duration(seconds: secondToAdd), () {
          add(Obstacle());
          add(LetterObstacles());
        });
      }

      add(Obstacle());
      add(LetterObstacles());
      if (elapsedSeconds > 10.0) {
        addShipAtSecond(3);
      }
      if (elapsedSeconds > 20.0) {
        addShipAtSecond(2);
      }
      if (elapsedSeconds > 30.0) {
        addShipAtSecond(4);
      }
    };
  }

  @override
  void update(double dt) {
    interval.update(dt);
    super.update(dt);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onTapUp(TapUpEvent event) {
    gameRef.gravity.y -= 20;

    super.onTapUp(event);
  }
}
