import 'dart:core';
import 'board_base.dart';
import 'game_base.dart';

abstract class Rule {
  // try to make a move.
  // If the given move is legal, return the new GameNode for result of this
  // move, otherwise return null.
  GameNode tryMakeMove(List<GameNode> context, Stone stone, int x, int y);
}

class DefaultGoRule implements Rule {
  @override
  GameNode tryMakeMove(List<GameNode> context, Stone stone, int x, int y) {
    
    return null;
  }

}