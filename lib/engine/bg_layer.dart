import 'package:flame/components.dart';
import 'package:flame/layers.dart';

class BgLayer extends PreRenderedLayer{
  final Sprite _sprite;
  final Vector2 _size;

  BgLayer(this._sprite,this._size);

  @override
  void drawLayer() {
    _sprite.render(canvas,position: Vector2(0,0),size: _size);
  }

}