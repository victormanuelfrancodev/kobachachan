import 'package:eathiraganaandkatakana/basegame/capture_halloween.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flame/timer.dart';


class Clock extends SpriteComponent with HasGameRef<CaptureHalloween>{

  late Rect _rect;
  late Timer _countdown;
  late double _time;

  double sizeYRender = 0;

  Clock( this._time);

  @override
  Future<void>? onLoad() {
    //debugMode = true;
    size = Vector2(gameRef.size.x * 0.20 , 10 );
    position = Vector2(gameRef.size.x * 0.60,gameRef.size.y * 0.10);
    _rect = Rect.fromLTWH(position.x, position.y ,size.x, size.y);
    //timer
    _countdown = Timer(_time);
    _countdown.start();
    changePriorityWithoutResorting(10);
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
      canvas.drawRect(_rect, Paint()
        ..color = Colors.white);
      canvas.drawRect(
          Rect.fromLTWH(position.x, position.y, calculatePosition(_countdown.current),size.y), Paint()
        ..color = Colors.red);

    super.render(canvas);
  }

  //Get the size Y
  double calculatePosition(double actualTime){
    var timeTotal = (actualTime * 100) / _time;
    var total = (timeTotal * size.x) / 100;
    return total;
  }

  void startTimer(){
    _countdown.start();
  }

  @override
  void update(double dt) {
    _countdown.update(dt);
    if (_countdown.finished){
     gameRef.getEngineGame.createGameOverScreen();

    }
    super.update(dt);
  }

  double get getCoutDown => _countdown.current;

  incrementTime(double time){
    _countdown = Timer(70);
    _countdown.start();
  }
}