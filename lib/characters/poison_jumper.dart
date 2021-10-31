
import 'dart:math';

import 'package:eathiraganaandkatakana/basegame/capture_halloween.dart';
import 'package:eathiraganaandkatakana/characters/cobacha_chan.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';


class PoisonJumper extends SpriteComponent with Hitbox,Collidable,HasGameRef<CaptureHalloween>{

  @override
  Future<void>? onLoad() async{
    addHitbox(HitboxRectangle());
    //debugMode = true;
    sprite = await Sprite.load('icons_8_48.png');
    size = Vector2(35,35);

    var randomPosition = Random().nextInt(gameRef.size.y.toInt() + (gameRef.size.y * 0.45).toInt() );

    position = Vector2(gameRef.size.x + 15, randomPosition.toDouble());

    changePriorityWithoutResorting(2);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.x -= 7;
    if(position.x <  - size.x ){
      gameRef.remove(this);
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {

    if (other is CobachaChan) {
      if(gameRef.getEngineGame.getButtonEat.isButtonEatPressed){
        gameRef.remove(this);
        gameRef.getEngineGame.getCobachachan.changeJump();
      }
    }
    super.onCollision(intersectionPoints, other);
  }

}