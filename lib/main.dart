
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import  'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:spacex/actors/letter_obstacles.dart';
import 'package:spacex/utils/audio_manager.dart';

import 'gui/heart.dart';
import 'overlays/life.dart';
import 'overlays/pause_button.dart';
import 'overlays/pause_menu.dart';
import 'widgets/blast_animation.dart';
import 'actors/player.dart';
import 'screens/game_over_screen.dart';
import 'screens/game_play_screen.dart';
import 'screens/start_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GamePlay(),));
}


class GamePlay extends StatelessWidget {
  //const GamePlay({Key? key}) : super(key: key);
  SpaceGame spaceGame=SpaceGame();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // WillPopScope provides us a way to decide if
      // this widget should be poped or not when user
      // presses the back button.
      body: WillPopScope(
        onWillPop: () async => false,
        // GameWidget is useful to inject the underlying
        // widget of any class extending from Flame's Game class.
        child: GameWidget(
          game: spaceGame,
          //initialActiveOverlays: [PauseButton.ID],
          overlayBuilderMap: {
            PauseButton.ID:(BuildContext context,SpaceGame gameRef)=>PauseButton(gameRef:gameRef,),
            PauseMenu.ID:(BuildContext context,SpaceGame gameRef)=>PauseMenu(gameRef:gameRef,),
            Life.ID:(BuildContext context,SpaceGame gameRef)=>Life(gameRef:gameRef,),
          },
        ),
      ),
    );
  }
}
class SpaceGame extends FlameGame
    with HasTappableComponents,HasCollisionDetection,VerticalDragDetector {
  Player player=Player();
  Heart heart=Heart();
  LetterObstacles letterObstacles=LetterObstacles();
  BlastAnimation blast=BlastAnimation();
  Vector2 gravity = Vector2(0, 30);
  late final RouterComponent router;
  bool gameOver = false;
  bool showingGameOverScreen = false;
  //Player crow = Player();
  Stopwatch elapsedTime = Stopwatch();
 Vector2? pointerStartPosition=Vector2(0,0);
 Vector2? pointerCurrentPosition=Vector2(0,0);
  Vector2? delta;
  Image life=Image.asset('life.png');
  var lives=2;
  @override
  void onLoad() async {
    super.onLoad();
    Flame.device.setLandscape();
    await AudioManager.init();
    add(
      router = RouterComponent(
        initialRoute: 'start',
        routes: {
          'gameplay': Route(GamePlayScreen.new),
          'gameover': Route(GameOverScreen.new),
          'start': Route(StartScreen.new),
        },
      ),
    );
  }

  @override
  void update(double dt) {
    if (gameOver && !showingGameOverScreen) {
      router.pushNamed('gameover');
      showingGameOverScreen = true;
    }
    super.update(dt);
  }


  @override
  void onVerticalDragStart(DragStartInfo info) {

    pointerStartPosition=info.eventPosition.global;

    super.onVerticalDragStart(info);
  }

  @override
  void onVerticalDragUpdate(DragUpdateInfo info) {
     AudioManager.playSfx('audio_jump.mp3');
     pointerCurrentPosition=info.eventPosition.global;
     delta= pointerCurrentPosition! - pointerStartPosition!;

    super.onVerticalDragUpdate(info);
  }

  @override
  void onVerticalDragEnd(DragEndInfo info) {

    pointerCurrentPosition=Vector2(0,pointerCurrentPosition!.y);
    pointerStartPosition=Vector2(0, pointerStartPosition!.y);

    super.onVerticalDragEnd(info);
  }

}
