
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/parallax.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:spacex/actors/letter_obstacles.dart';
import 'package:spacex/actors/word_letters.dart';


import '../actors/obstacle.dart';
import '../widgets/word_display.dart';
import '../gui/elapsed_time.dart';
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

    add(gameRef.hud);
    add(gameRef.player);
    add(LetterObstacles());
    add(WordLetters());
    add(Word());

   // add(gameRef.wordDisplay);
    addShips();
  }

  void addShips() {
    interval.onTick = () {
     // double elapsedSeconds = gameRef.elapsedTime.elapsed.inSeconds.toDouble();

        Future.delayed(Duration(seconds: 1), () {
          add(Obstacle());
        });
        Future.delayed(Duration(seconds: 2), () {
          add(WordLetters());
        });
        Future.delayed(Duration(seconds: 2), () {
          add(LetterObstacles());
        });

    };
  }

  @override
  void update(double dt) {
    interval.update(dt);
    super.update(dt);
  }

}
