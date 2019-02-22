import 'dart:core';
import 'board_base.dart';
import 'rule_base.dart';

// A game node represents a move in a board game.
// Except board status on this move, a node also
// holds variations, comments, marks, etc.
class GameNode {
  Board board;
  List<GameNode> variantations;

  GameNode() {
    board = Board();
    variantations = new List<GameNode>();
  }

  GameNode.fromNode(GameNode orignNode) {
    board = Board.fromBoard(orignNode.board);
    variantations = new List<GameNode>();
  }
}

// A game is a tree of game nodes. Nodes on trunk
// represent the actual game moves, and nodes on
// branches represent some variatations.
// The basic operation on a game is to play moves.
// Game uses rules to determine if move is legal
// or illegal.
class Game {
  List<GameNode> _trunk;
  Rule rule;

  // default constructor creates a game with empty
  // board with default size, and uses default rules.
  Game() {
    _trunk = List<GameNode>()
      ..add(GameNode());
    rule =DefaultGoRule();
  }

  makeMove(Stone stone, int x, int y) {
    
  }
}