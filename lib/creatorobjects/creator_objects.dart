


import 'dart:math';

import 'package:eathiraganaandkatakana/basegame/capture_halloween.dart';
import 'package:eathiraganaandkatakana/characters/candy.dart';
import 'package:eathiraganaandkatakana/characters/ghost.dart';
import 'package:eathiraganaandkatakana/characters/hand.dart';
import 'package:eathiraganaandkatakana/characters/multiplier_poison.dart';
import 'package:eathiraganaandkatakana/characters/poison_jumper.dart';
import 'package:eathiraganaandkatakana/characters/spider.dart';
import 'package:eathiraganaandkatakana/poisons/increment_time.dart';
import 'package:flame/components.dart';

class CreatorObjects {

  late CaptureHalloween _gameRef;

  CreatorObjects(this._gameRef);
  late Timer _timer;

  init() {
    _createTimeInAppear();
  }

  _createTimeInAppear() {
    var randomTime = Random().nextInt(10).toDouble();
    _timer = Timer(randomTime, callback: () {
      var randomSelectObject = Random().nextInt(10);

      switch(randomSelectObject){
        case 0: _appearCandy(); break;
        case 1: _appearHand(); break;
        case 2: _appearGhots(); break;
        case 3: _appearTimePoison(); break;
        case 4: _appearSpider(); break;
        case 5: _appearMultiplierCandy(); break;
        case 6: _appearJumper(); break;
        case 7: _appearCandy(); break;
        case 8: _appearCandy(); break;
        case 9: _appearCandy(); break;
      }
    }, repeat: false);
    _timer.start();
  }

  _appearTimePoison(){
    var incrementTimer = IncrementTime();
    _gameRef.add(incrementTimer);
  }

  _appearMultiplierCandy(){
    var multiplierCandy = MultiplierPoison();
    _gameRef.add(multiplierCandy);
  }

  _appearJumper(){
    var appearJumper = PoisonJumper();
    _gameRef.add(appearJumper);
  }

  void update(double dt) {
    _timer.update(dt);
    if(_timer.finished){
      _createTimeInAppear();
    }
  }

  stop(){
    _timer.stop();
  }

  _appearCandy() {
    var candy = Candy();
    _gameRef.add(candy);
  }

  _appearHand() {
    var hand = Hand();
    _gameRef.add(hand);
  }

  _appearGhots(){
    var ghost = Ghost();
    _gameRef.add(ghost);
  }

  _appearSpider(){
    var spider = Spider();
    _gameRef.add(spider);
  }
}