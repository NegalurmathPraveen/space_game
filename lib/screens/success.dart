import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart' hide Route;

import '../main.dart';
import '../overlays/pause_button.dart';


class SuccessScreen extends Component with HasGameRef<SpaceGame>, TapCallbacks {
  @override
  void onLoad() async {
    await super.onLoad();
    Flame.device.setLandscape();

    add(
      TextComponent(
        text:'time: ${gameRef.elapsedTime.elapsed.inSeconds}',
        anchor: Anchor.center,
        position: Vector2(gameRef.size.x*0.5,gameRef.size.y*0.3),
        textRenderer:
        TextPaint(style: const TextStyle(fontSize: 50, color: Colors.white)),
      ),
    );
    add(
      TextComponent(
        text: 'CONGRATULATIONS',
        anchor: Anchor.center,
        position: gameRef.size / 2,
        textRenderer:
        TextPaint(style: const TextStyle(fontSize: 64, color: Colors.amber)),
      ),
    );
  }

  @override
  void update(double dt) {
    if (gameRef.elapsedTime.isRunning) {
      gameRef.elapsedTime.reset();
      gameRef.elapsedTime.stop();
      gameRef.pauseEngine();
    }
    super.update(dt);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onTapUp(TapUpEvent event) {
    gameRef.player.position = gameRef.size / 2;
    gameRef.showingSuccessScreen = false;
    gameRef.success = false;
    gameRef.router.pop();
   gameRef.elapsedTime.start();
   gameRef.overlays.add(PauseButton.ID);
    gameRef.lives=3;
    gameRef.list1.removeRange(0,gameRef.list1.length);
    gameRef.resumeEngine();
    super.onTapUp(event);
  }
}
