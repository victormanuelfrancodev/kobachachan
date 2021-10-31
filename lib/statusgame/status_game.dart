/* Status of game */
enum View{
  startgame,
  playing,
  gameOver,
  pause,
  instructions,
}

class StatusGame{
  static View statusGame = View.startgame;
}