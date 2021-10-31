
import 'package:eathiraganaandkatakana/basegame/capture_halloween.dart';
import 'package:eathiraganaandkatakana/global/global.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CobachaChan extends SpriteAnimationComponent with Hitbox,Collidable ,Tappable,HasGameRef<CaptureHalloween>{
  late SpriteAnimation _cobachanRunSpriteAnimation;
  late SpriteAnimation _cobachanJumpSpriteAnimation;
  late SpriteAnimation _cobachanDieSpriteAnimation;

  late SpriteAnimation _actualAnimation = _cobachanRunSpriteAnimation;
  bool isJump = false;
  MoveEffect? _currentEffect;
  late Timer _timer;
  double animationTime = 0.2;

  //Poisons timer
  late Timer _timerPoisons;
  double animationTimePoisons = 3.0;


  CobachaChan(this._cobachanRunSpriteAnimation, this._cobachanJumpSpriteAnimation,this._cobachanDieSpriteAnimation){
    //debugMode = true;
    _timer = Timer(animationTime);
    _timerPoisons = Timer(animationTimePoisons);
    animation = _cobachanRunSpriteAnimation;
    addHitbox(HitboxCircle(definition: 0.6));
    changePriorityWithoutResorting(3);
  }

  @override
  Future<void>? onLoad() {
    if (kIsWeb) {
      position = Vector2(gameRef.size.x * .10, gameRef.size.y * 0.70);
    } else {
      position = Vector2(gameRef.size.x * .10, gameRef.size.y * 0.65);
    }

    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 gameSize) {
    size = Vector2(gameSize.x*0.15, gameSize.x * .15);
    if (kIsWeb) {
      position = Vector2(gameRef.size.x * .10, gameRef.size.y * 0.70);
    } else {
      position = Vector2(gameRef.size.x * .10, gameRef.size.y * 0.65);
    }
    super.onGameResize(gameSize);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    if (!isJump) {
      jump();
    }
    return true;
  }

  jump(){
    FlameAudio.play('jump.wav');
    if(_currentEffect != null){
      remove(_currentEffect!);
    }

    _currentEffect = MoveEffect(
        path: [
          Vector2(0, Global.JUMP.toDouble()),
        ],
        speed: 250.0,
        curve: Curves.ease,
        isAlternating: true,
        isRelative: true,
        onComplete: (){
          isJump = false;
        }
      );
      isJump = true;
      add(_currentEffect!);
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    _timerPoisons.update(dt);
    if(_timerPoisons.finished){
      _timer.stop();
      Global.JUMP = kIsWeb? -300:-145;
      Global.MULTIPLIER_CANDYS = 1;
    }
    if(_timer.finished){
      _timer.stop();
      changeRun();
    }
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    animation = _actualAnimation;
    super.render(canvas);
  }

  changeEat(){
    _timer.start();
    _actualAnimation = _reactionOfCabacha(CabachaAnimation.eat);
  }

  changeJump(){
    if(_timerPoisons.isRunning()){
      _timerPoisons.stop();
      _timerPoisons.start();
    }else{
      _timerPoisons.start();
    }
    Global.JUMP = kIsWeb? -400: -270;
  }

  changeMultiplierCandys(){
    if(_timerPoisons.isRunning()){
      _timerPoisons.stop();
      _timerPoisons.start();
    }else{
      _timerPoisons.start();
    }
    Global.MULTIPLIER_CANDYS = 2;
  }

  changeRun(){
    _actualAnimation = _reactionOfCabacha(CabachaAnimation.run);
  }

  changeDie(){
    _timer.start();
    _actualAnimation = _reactionOfCabacha(CabachaAnimation.die);
  }

  _reactionOfCabacha(CabachaAnimation cabachaAnimation){
    switch(cabachaAnimation){
      case CabachaAnimation.run: return _cobachanRunSpriteAnimation;
      case CabachaAnimation.eat : return _cobachanJumpSpriteAnimation;
      case CabachaAnimation.die: return _cobachanDieSpriteAnimation;
    }
  }
}

enum CabachaAnimation {
  run,
  eat,
  die
}
