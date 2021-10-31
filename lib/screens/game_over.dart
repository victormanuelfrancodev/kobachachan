import 'package:eathiraganaandkatakana/basegame/capture_halloween.dart';
import 'package:eathiraganaandkatakana/engine/background.dart';
import 'package:eathiraganaandkatakana/engine/play_button.dart';

class GameOver {
  final CaptureHalloween _captureHalloween;
  late Background _background;
  late PlayButton _playButton;
  late bool isWinner;


  GameOver(this._captureHalloween, this.isWinner);

  setScreen(){
    if (isWinner){
      _background = Background('win.png');
    }else{
      _background = Background('gameover.png');
    }
    _playButton = PlayButton();
    _captureHalloween.add(_background);
    _captureHalloween.add(_playButton);
  }

  deleteElements(){
    _captureHalloween.remove(_background);
    _captureHalloween.remove(_playButton);
  }

}