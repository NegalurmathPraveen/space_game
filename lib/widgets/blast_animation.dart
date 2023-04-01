import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../main.dart';

class BlastAnimation extends SpriteAnimationComponent
    with HasGameRef<SpaceGame> {
  BlastAnimation() : super() {
    // debugMode = true;
  }
  @override
  void onLoad() async {
    await super.onLoad();
    final blastAnimation = await gameRef.loadSpriteAnimation(
        'player.png',
        SpriteAnimationData.sequenced(
            amount: 28,
            amountPerRow: 7,texturePosition:Vector2(0,300),
            stepTime: 0.5,
            textureSize: Vector2(100, 100)));
    animation = blastAnimation;
    position =Vector2(0,gameRef.pointerCurrentPosition!.y)-Vector2(0,gameRef.pointerStartPosition!.y);
    anchor= Anchor.centerRight;
    size = Vector2(gameRef.size.y * 100/ 400, gameRef.size.y) * .5;
  }

}
