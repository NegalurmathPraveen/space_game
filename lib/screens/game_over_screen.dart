import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:spacex/screens/game_play_screen.dart';

import '../main.dart';
import '../overlays/pause_button.dart';


class GameOverScreen extends Component with HasGameRef<SpaceGame>, TapCallbacks {
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
        text: 'GAME OVER',
        anchor: Anchor.center,
        position: gameRef.size / 2,
        textRenderer:
            TextPaint(style: const TextStyle(fontSize: 64, color: Colors.red)),
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
    gameRef.showingGameOverScreen = false;
    gameRef.gameOver = false;
    gameRef.router.pop();
    gameRef.elapsedTime.start();
    gameRef.overlays.add(PauseButton.ID);
    gameRef.resumeEngine();
    super.onTapUp(event);
  }
}
