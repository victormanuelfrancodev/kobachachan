

import 'package:eathiraganaandkatakana/actionskobacha/button_eat.dart';
import 'package:eathiraganaandkatakana/basegame/capture_halloween.dart';
import 'package:eathiraganaandkatakana/characters/cobacha_chan.dart';
import 'package:eathiraganaandkatakana/characters/parallax_scene.dart';
import 'package:eathiraganaandkatakana/creatorobjects/creator_objects.dart';
import 'package:eathiraganaandkatakana/engine/clock.dart';
import 'package:eathiraganaandkatakana/global/global.dart';
import 'package:eathiraganaandkatakana/lifebar/life_heart.dart';
import 'package:eathiraganaandkatakana/screens/game_over.dart';
import 'package:eathiraganaandkatakana/screens/start_game.dart';
import 'package:eathiraganaandkatakana/statusgame/status_game.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class EngineGame {

  late CaptureHalloween _captureHalloween;
  CreatorObjects? _creatorObjects;
  late CobachaChan _cobachachan;
  late ButtonEat _buttonEat;
  List<LifeHeart> lifeHeartList = [];
  late Clock _clock;
  Clock get getClock => _clock;
  late TextComponent scoreText;
  String textCounterScore = 'Counter Candy: 0/5';

  //scenes
  late StartGame _startGame;
  late GameOver _gameOver;

  EngineGame(this._captureHalloween);

  //Scren start game menu
  startGame(){
    if(StatusGame.statusGame == View.gameOver){
      _gameOver.deleteElements();
    }
    _createStartGame();
  }

  //Create Menu Scene
  _createStartGame(){
    //Set State
    StatusGame.statusGame = View.startgame;
    //Create menu game
    _startGame = StartGame(_captureHalloween);
    _startGame.setInstructions();
  }

  createGameOver(){
    //Set State
    StatusGame.statusGame = View.gameOver;
    _gameOver = GameOver(_captureHalloween,false);
    _gameOver.setScreen();
  }

  createGameOverWin(){
    //Set State
    StatusGame.statusGame = View.gameOver;
    _gameOver = GameOver(_captureHalloween,true);
    _gameOver.setScreen();
  }
  //////////////////////////
  //create game
  //////////////////////////
  createNewGame(){
    if(StatusGame.statusGame == View.gameOver){
      _gameOver.deleteElements();
    }else{
      _startGame.deleteElements();
    }

    StatusGame.statusGame = View.playing;
    Global.TOTAL_LIFES = 5;
    Global.JUMP = kIsWeb? -300: -145;
    Global.CANDYS_COUNTER = 0;
    Global.MULTIPLIER_CANDYS = 1;
    createScene();
  }

  //delete all elements
  deleteElementsGaming(){
    _creatorObjects!.stop();
    _creatorObjects = null;
    StatusGame.statusGame = View.gameOver;
    lifeHeartList = [];
    Global.TOTAL_LIFES = 5;
    for (var element in _captureHalloween.children) {
        _captureHalloween.remove(element);
    }
  }

  //Create scenario
  createScene(){
    _createParallax();
    _createPrincipalCharacter();
    _createObjects();
    _createButtons();
    _createClock();
    _createLifeBar();
    _createCounter();
  }

  _createCounter(){
    //Score text
    scoreText = TextComponent(textCounterScore, textRenderer: TextPaint(config: TextPaintConfig(color: BasicPalette.white.color, fontSize: 14)),
    position:  Vector2(_captureHalloween.size.x * 0.10,_captureHalloween.size.y * 0.25));

    scoreText.changePriorityWithoutResorting(4);
    _captureHalloween.add(scoreText);
  }

  _createClock(){
    _clock = Clock(80);
    //_clock.startTimer();
    _captureHalloween.add(_clock);
  }
  _createButtons(){
    _buttonEat = ButtonEat();
    _captureHalloween.add(_buttonEat);
  }

  //create objects random candys, hands and more
  _createObjects(){
    _creatorObjects = CreatorObjects(_captureHalloween);
    _creatorObjects!.init();
  }

  //Create parallax
  _createParallax(){
    _captureHalloween.add(ParallaxBar()..changePriorityWithoutResorting(0));
  }

  //Create capture pumpkins
  _createPrincipalCharacter()async{
    //load run animation
    final animationRun = await _captureHalloween.loadSpriteAnimation(
      'cobacharun.png',
      SpriteAnimationData.sequenced(
        amount: 11,
        textureSize: Vector2(900.0, 900.0),
        stepTime: 0.08,
      ),
    );
    final animationEat = await _captureHalloween.loadSpriteAnimation(
      'eatcandy.png',
      SpriteAnimationData.sequenced(
        amount: 11,
        textureSize: Vector2(900.0, 900.0),
        stepTime: 0.08,
      ),
    );
    final animationDie = await _captureHalloween.loadSpriteAnimation(
      'die.png',
      SpriteAnimationData.sequenced(
        amount: 11,
        textureSize: Vector2(900.0, 900.0),
        stepTime: 0.11,
      ),
    );
    //Principal character
    _cobachachan = CobachaChan(animationRun, animationEat,animationDie);
    _captureHalloween.add(_cobachachan);
  }

  //Get character cobachachan
  CobachaChan get getCobachachan => _cobachachan;
  ButtonEat get getButtonEat => _buttonEat;


  _createLifeBar(){
    for(var i = 0; i < Global.TOTAL_LIFES; i++){
      lifeHeartList.add(LifeHeart(
        Vector2((_captureHalloween.size.x * 0.08) + ( (_captureHalloween.size.x * 0.08)  * i), _captureHalloween.size.y * 0.08 ),
      ));
    }
    for( var lifes in lifeHeartList){
      _captureHalloween.add(lifes);
    }
  }

  deleteKobachaLife(){
    Global.TOTAL_LIFES -= 1;
    lifeHeartList = [];
    for (var element in _captureHalloween.children) {
      if(element.runtimeType == LifeHeart){
        _captureHalloween.remove(element);
      }
    }
    _createLifeBar();
    if (Global.TOTAL_LIFES == 0){
      deleteElementsGaming();
      createGameOver();
    }
  }

  createGameOverScreen(){
    StatusGame.statusGame = View.gameOver;
    deleteElementsGaming();
    createGameOver();
  }


  void update(double dt){
    if(_creatorObjects != null){
      _creatorObjects!.update(dt);
    }

    if(StatusGame.statusGame == View.playing){
      scoreText.text = 'Counter Candy: ${Global.CANDYS_COUNTER}/5';
      if(Global.CANDYS_COUNTER == 5){
        createGameOverWin();
      }
    }

  }
}