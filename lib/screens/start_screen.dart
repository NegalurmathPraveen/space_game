import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart' hide Route;

import '../main.dart';
import '../overlays/pause_button.dart';
import '../utils/audio_manager.dart';

class StartScreen extends Component with HasGameRef<SpaceGame>, TapCallbacks {
  @override
  void onLoad() async {
    await super.onLoad();
    Flame.device.setLandscape();
    add(
      TextComponent(
        text: 'START',
        anchor: Anchor.center,
        position: gameRef.size / 2,
        textRenderer: TextPaint(
            style: const TextStyle(fontSize: 64, color: Colors.green)),
      ),
    );
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onTapUp(TapUpEvent event) {
    gameRef.router.pushNamed('gameplay');
    //AudioManager.playBgm('audio_jump.mp3');
    gameRef.overlays.add(PauseButton.ID);
    super.onTapUp(event);
  }
}
