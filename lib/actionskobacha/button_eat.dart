

import 'package:eathiraganaandkatakana/basegame/capture_halloween.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ButtonEat extends SpriteComponent with Tappable,HasGameRef<CaptureHalloween>{
  //if a candy or other stay near, eat
  bool isButtonEatPressed = false;
  ButtonEat();

  @override
  Future<void>? onLoad() async{
    changePriorityWithoutResorting(3);
    sprite = await Sprite.load('kill.png');
    if (kIsWeb) {
      position = Vector2(gameRef.size.x * .20, gameRef.size.y * 0.50);
    } else {
      position = Vector2(gameRef.size.x * 0.90, gameRef.size.y * 0.20);
    }

    size = Vector2(70,70);
    anchor = Anchor.center;
    return super.onLoad();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    FlameAudio.play('kick.wav');
    isButtonEatPressed = true;
    gameRef.getEngineGame.getCobachachan.changeEat();
    return true;
  }

  @override
  bool onTapUp(TapUpInfo info) {
    isButtonEatPressed = false;

    return super.onTapUp(info);
  }


}