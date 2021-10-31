
import 'package:eathiraganaandkatakana/basegame/capture_halloween.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

import 'bg_layer.dart';

class Background extends PositionComponent with HasGameRef<CaptureHalloween>{

  late BgLayer _bgLayerBackground;
  late String _img;

  Background(this._img);

  @override
  Future<void>? onLoad() async{
    final spriteBg = await Sprite.load(_img);
    _bgLayerBackground = BgLayer(spriteBg, gameRef.size);

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    _bgLayerBackground.render(canvas);
    super.render(canvas);
  }


}

