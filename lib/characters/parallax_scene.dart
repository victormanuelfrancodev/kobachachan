
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

class ParallaxBar extends ParallaxComponent {

  @override
  Future<void>? onLoad() async{
    await  super.onLoad();
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData('1parallax.png'),
        ParallaxImageData('2parallax.png'),
        ParallaxImageData('3parallax.png'),
        ParallaxImageData('4parallax.png'),
        ParallaxImageData('6parallax.png'),
        ParallaxImageData('7parallax.png'),
      ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.5, 10.0),
    );
  }
}
