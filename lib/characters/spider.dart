

import 'dart:math';

import 'package:eathiraganaandkatakana/basegame/capture_halloween.dart';
import 'package:eathiraganaandkatakana/characters/cobacha_chan.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/animation.dart';

class Spider extends SpriteComponent with Hitbox,Collidable,HasGameRef<CaptureHalloween>{

  MoveEffect? _currentEffectHand;
  bool appear = false;

  @override
  Future<void>? onLoad() async{
    addHitbox(HitboxCircle());
    //debugMode = true;
    sprite = await Sprite.load('24.png');
    size = Vector2(70,70);
    var random = Random().nextInt(gameRef.size.x.toInt());
    random = ((gameRef.size.x * .20 ).toInt() + random);
    position = Vector2(random.toDouble(), 0);
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
      gameRef.getEngineGame.getCobachachan.changeDie();
      gameRef.camera.shake(duration: 0.3, intensity: 1.0);
    }
    super.onCollision(intersectionPoints, other);
  }

  addEffect(){
    var random = Random().nextInt(200);
    _currentEffectHand = MoveEffect(
        path: [
          Vector2( 0 ,random.toDouble()),

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