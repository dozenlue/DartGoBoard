import 'package:board/board.dart';

main() {
  var board = new Board();

  print('board size: ${board.boardSize}');

  const int mask  = 0x0400000000000000;
  int value = 0x0F00000000000000;
  value &= ~mask;

  print('result: ${value.toRadixString(16)}');
}
