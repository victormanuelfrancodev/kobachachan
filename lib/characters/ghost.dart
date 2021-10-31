
import 'dart:math';

import 'package:eathiraganaandkatakana/basegame/capture_halloween.dart';
import 'package:eathiraganaandkatakana/global/global.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flutter/animation.dart';

import 'cobacha_chan.dart';

class Ghost extends SpriteComponent with Hitbox,Collidable,Tappable,HasGameRef<CaptureHalloween>{

  MoveEffect? _currentEffect;
  @override
  Future<void>? onLoad() async{
    addHitbox(HitboxRectangle());
    //debugMode = true;
    sprite = await Sprite.load('ghost.png');
    size = Vector2(40,40);
    var random = Random().nextInt(gameRef.size.y.toInt());

    position = Vector2(gameRef.size.x +15, random.toDouble());

    changePriorityWithoutResorting(2);
    addEffect();
    return super.onLoad();
  }

  addEffect(){
    var random = Random().nextInt(gameRef.size.y.toInt());
    _currentEffect = MoveEffect(
        path: [
          Vector2(-gameRef.size.x - 70, - random.toDouble()),
        ],
        speed: 60.0,
        isInfinite: false,
        curve: Curves.elasticOut,
        isAlternating: true,
        isRelative: true,

    );
    add(_currentEffect!);

  }

  @override
  void update(double dt) {
    position.x -= 5;
    if(position.x <  - size.x ){
      gameRef.remove(this);
    }
    super.update(dt);
  }


  @override
  bool onTapDown(TapDownInfo info) {
    gameRef.remove(this);
    var random = Random().nextInt(2);
    if (random == 1){
      Global.CANDYS_COUNTER += 1 * Global.MULTIPLIER_CANDYS;
    }else{
      gameRef.getEngineGame.getClock.incrementTime(20);
    }
    return true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {

    if (other is CobachaChan) {

      gameRef.getEngineGame.getCobachachan.changeDie();
      gameRef.camera.shake(duration: 0.3, intensity: 1.0);
      gameRef.remove(this);
      //quit 1 life
      gameRef.getEngineGame.deleteKobachaLife();
    }
    super.onCollision(intersectionPoints, other);
  }

}