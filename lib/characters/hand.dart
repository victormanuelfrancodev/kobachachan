

import 'dart:math';

import 'package:eathiraganaandkatakana/basegame/capture_halloween.dart';
import 'package:eathiraganaandkatakana/characters/cobacha_chan.dart';
import 'package:eathiraganaandkatakana/global/global.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/animation.dart';

class Hand extends SpriteComponent with Hitbox,Collidable,HasGameRef<CaptureHalloween>{

  MoveEffect? _currentEffectHand;
  bool appear = false;

  @override
  Future<void>? onLoad() async{
    addHitbox(HitboxCircle());
    sprite = await Sprite.load('40.png');
    size = Vector2(50,70);
    var random = Random().nextInt(gameRef.size.x.toInt());
    random = ((gameRef.size.x * .20 ).toInt() + random);
    position = Vector2(random.toDouble(), gameRef.size.y + 70);
    changePriorityWithoutResorting(2);
    addEffect();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if(appear){
      position.x -= 3;
      if(position.x <  - size.x ){
          if(_currentEffectHand != null){
            remove(_currentEffectHand!);
          }
          gameRef.remove(this);
      }
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {

    if (other is CobachaChan) {
      gameRef.remove(this);
      //change animation
      gameRef.getEngineGame.getCobachachan.changeDie();
      //shake!
      gameRef.camera.shake(duration: 0.3, intensity: 1.0);
      //quit 1 life
      gameRef.getEngineGame.deleteKobachaLife();
    }
    super.onCollision(intersectionPoints, other);
  }

  addEffect(){
    _currentEffectHand = MoveEffect(
      path: [
        Vector2( 0 ,-150),

      ],
      speed: 100.0,
      isInfinite: false,
      curve: Curves.ease,
      isAlternating: false,
      isRelative: true,
      onComplete: (){
        appear = true;
      }

    );

    add(_currentEffectHand!);

  }

}