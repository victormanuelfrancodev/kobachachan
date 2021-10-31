import 'package:eathiraganaandkatakana/basegame/capture_halloween.dart';
import 'package:eathiraganaandkatakana/engine/background.dart';
import 'package:eathiraganaandkatakana/engine/play_button.dart';

class StartGame {
  final CaptureHalloween _captureHalloween;
  late Background _background;
  late PlayButton _playButton;


  StartGame(this._captureHalloween);

  setInstructions(){
    _background = Background('welcome.png');
    _playButton = PlayButton();
    _captureHalloween.add(_background);
    _captureHalloween.add(_playButton);
  }

  deleteElements(){
    _captureHalloween.remove(_background);
    _captureHalloween.remove(_playButton);

  }

}