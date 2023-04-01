import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/audio_manager.dart';
import 'pause_button.dart';

class PauseMenu extends StatelessWidget {
  static const String ID='PauseMenu';
  final SpaceGame gameRef;
  const PauseMenu({Key? key,required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Text(
              'Paused',
              style: TextStyle(
                fontSize: 50,
                color: Colors.black,
                shadows: [
                  Shadow(
                      blurRadius: 20.0,
                      color: Colors.white,
                      offset: Offset(0, 0))
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                gameRef.resumeEngine();
                gameRef.overlays.remove(PauseMenu.ID);
                gameRef.overlays.add(PauseButton.ID);
                AudioManager.resumeBgm();
              },
              child: Text('Resume'),
            ),
          ),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width / 3,
          //   child: ElevatedButton(
          //     onPressed: () {
          //       gameRef.showingGameOverScreen = false;
          //       gameRef.gameOver = false;
          //       gameRef.elapsedTime.start();
          //       gameRef.router.pop();
          //
          //     },
          //     child: Text('Exit'),
          //   ),
          // )
        ],
      ),
    );
  }
}
