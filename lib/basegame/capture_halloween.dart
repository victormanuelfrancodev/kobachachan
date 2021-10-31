import 'package:eathiraganaandkatakana/engine/enginee_game.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';

class CaptureHalloween extends FlameGame with HasTappableComponents,HasCollidables{

  late EngineGame _engineGame;

  @override
  Future<void>? onLoad() async{
    FlameAudio.bgm.stop();
    FlameAudio.playLongAudio('rock.mp3');
    _engineGame = EngineGame(this);
    _engineGame.startGame();
    return super.onLoad();
  }

  initialize() async{
    await Flame.device.setLandscape();
  }

  @override
  void update(double dt) {
    _engineGame.update(dt);
    super.update(dt);
  }

  EngineGame get getEngineGame => _engineGame;

}