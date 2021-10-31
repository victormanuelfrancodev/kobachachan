import 'package:eathiraganaandkatakana/basegame/capture_halloween.dart';
import 'package:eathiraganaandkatakana/statusgame/status_game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';


class PlayButton extends SpriteComponent with Tappable, HasGameRef<CaptureHalloween>{

  @override
  Future<void>? onLoad() async{
    final spritePlay = await Sprite.load('button-play-main.png');
    sprite = spritePlay;
    size = Vector2(420 * 0.30,200 * 0.30);
    if(StatusGame.statusGame == View.startgame){
      position = Vector2(gameRef.size.x * 0.81, gameRef.size.y * 0.75);
    }else if (StatusGame.statusGame == View.gameOver){
      position = Vector2(gameRef.size.x * 0.50 - ((420 * 0.30)/2), gameRef.size.y * 0.75);
    }
    changePriorityWithoutResorting(1);
    return super.onLoad();
  }


  @override
  bool onTapDown(TapDownInfo info) {
    if(StatusGame.statusGame == View.startgame){
      gameRef.getEngineGame.createNewGame();
    }else if (StatusGame.statusGame == View.gameOver){
      gameRef.getEngineGame.startGame();
    }

    return super.onTapDown(info);
  }


}