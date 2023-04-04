
import 'dart:math';

import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import  'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:spacex/actors/lives.dart';
import 'package:spacex/actors/letter_obstacles.dart';
import 'package:spacex/actors/word_display.dart';
import 'package:spacex/screens/success.dart';
import 'package:spacex/utils/audio_manager.dart';

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
          },
        ),
      ),
    );
  }
}
class SpaceGame extends FlameGame
    with HasTappableComponents,HasCollisionDetection,VerticalDragDetector {
  Player player=Player();
  WordDisplay wordDisplay=WordDisplay();
  Hud hud=Hud();
  List wordsList=[['G','U','M'],['S','I','M']];
  List list=['T','A','P'];
  List list1=['T','A','P'];
  LetterObstacles letterObstacles=LetterObstacles();
  BlastAnimation blast=BlastAnimation();
  late final RouterComponent router;
  bool gameOver = false;
  bool showingGameOverScreen = false;
  bool success = false;
  bool showingSuccessScreen= false;
  final _random = Random();
  Stopwatch elapsedTime = Stopwatch();
 Vector2? pointerStartPosition=Vector2(0,0);
 Vector2? pointerCurrentPosition=Vector2(0,0);
  Vector2? delta;
  Image life=Image.asset('life.png');
  var lives=3;
  HeartHealthComponent heartHealthComponent=HeartHealthComponent(heartNumber: 3, position: Vector2(0, 0), size: Vector2(0, 0));
  @override
  void onLoad() async {
    super.onLoad();
    Flame.device.setLandscape();
    await AudioManager.init();
    add(
      router = RouterComponent(
        initialRoute: 'start',
        routes: {
          'start': Route(StartScreen.new),
          'gameplay': Route(GamePlayScreen.new),
          'gameover': Route(GameOverScreen.new),
          'success':Route(SuccessScreen.new)

        },
      ),
    );
  }

  @override
  void update(double dt) {
    if (gameOver && !showingGameOverScreen) {
      router.pushNamed('gameover');
      showingGameOverScreen = true;
      list.removeRange(0,list.length);
      list.addAll(['T','A','P']);
    }
    else if(success &&!showingSuccessScreen)
      {
        router.pushNamed('success');
        showingSuccessScreen = true;
        list.addAll(wordsList.elementAt(_random.nextInt(wordsList.length)));
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
