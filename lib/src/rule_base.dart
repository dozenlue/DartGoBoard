import 'dart:core';
import 'board_base.dart';
import 'game_base.dart';

abstract class Rule {
  // try to make a move.
  // If the given move is legal, return the new GameNode for result of this
  // move, otherwise return null.
  GameNode tryMakeMove(GameNodeSequence context, Stone stone, Vertex v);
}

class DefaultGoRule implements Rule {
  @override
  GameNode tryMakeMove(GameNodeSequence context, Stone stone, Vertex v) {
    Stone opponent;
    GameNode newNode = GameNode.fromNode(orignNode: context.lastNode);

    // Only black or white stone makes a valid move
    if (stone == Stone.Black) {
      opponent = Stone.White;
    } else if (stone == Stone.White) {
      opponent = Stone.Black;
    } else {
      return null;
    }

    // If there is alread a stone, this is not a valid move
    if (newNode.board.stoneAt(v) != Stone.None) {
      return null;
    }

    // Just place the stone for further test
    newNode.board.placeStoneAt(stone, v);

    // If this move makes captures, it is a valid move
    Set<Vertex> captured = Set<Vertex>();

    newNode.board.neighborsOf(v).forEach((n) {
      if (newNode.board.stoneAt(n) == opponent
       && newNode.board.libertiesFrom(n).length == 0) {
         captured.addAll(newNode.board.chainFrom(n));
      }
    });

    if (captured.length != 0) {
      captured.forEach((n) {
        newNode.board.placeStoneAt(Stone.None, n);
      });

      return newNode;
    }

    // If this move doesn't make any capture, need to test suicide
    if (newNode.board.libertiesFrom(v).length > 0) {
      return newNode;
    }

    return null;
  }

}