import 'package:eathiraganaandkatakana/basegame/capture_halloween.dart';
import 'package:flame/components.dart';

class LifeHeart extends SpriteComponent with HasGameRef<CaptureHalloween>{

  late Vector2 _position;

  LifeHeart(this._position){
    position = _position;
  }

  @override
  Future<void>? onLoad() async{
    sprite = await Sprite.load('9.png');
    size = Vector2(50,50);
    changePriorityWithoutResorting(1);
    return super.onLoad();
  }
}