
import 'package:flutter/material.dart';
import 'package:spacex/main.dart';

import 'pause_menu.dart';

class PauseButton extends StatelessWidget {

 static const String ID='PauseButton';
 final SpaceGame gameRef;
 const PauseButton({Key? key,required this.gameRef}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: TextButton(
        child: Icon(Icons.pause_rounded,color: Colors.white,size: 30,),
        onPressed: (){
          gameRef.pauseEngine();
          gameRef.overlays.add(PauseMenu.ID);
          gameRef.overlays.remove(PauseButton.ID);
        },
      ),
    );
  }
}
