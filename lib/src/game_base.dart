import 'dart:core';
import 'package:meta/meta.dart';
import 'board_base.dart';
import 'rule_base.dart';

// A game node represents a move in a board game.
// Except board status on this move, a node also
// holds variations, comments, marks, etc.
class GameNode {
  Board board;
  List<GameNodeSequence> variantations;

  GameNodeSequence owner;

  GameNode({
    @required GameNodeSequence owner,
    int boardSize = Board.defaultBoardSize
  }) {
    board = Board(size: boardSize);
  }

  GameNode.fromNode({
    @required GameNode orignNode,
    GameNodeSequence ownerSequence
  }) {
    board = Board.fromBoard(orignNode.board);
    owner = ownerSequence == null ? orignNode.owner : ownerSequence;
  }
}

// A game node sequence represents a sequence of move.
// Such sequence could be a variantation of a node,
// or the trunk moves, when [orignNode] is null.
class GameNodeSequence {
  GameNode originNode;
  List<GameNode> _nodes;
  
  GameNodeSequence(this.originNode);

  int addNode(GameNode node) {
    if (_nodes == null) {
      _nodes = List<GameNode>();
    }

    _nodes.add(node);
    return _nodes.length - 1;
  }

  GameNode nodeAt(int index) {
    if (_nodes == null || index < 0 || index >= _nodes.length) {
      return null;
    }

    return _nodes[index];
  }

  GameNode get lastNode {
    return _nodes == null ? null : _nodes.last;
  }
}

// A game is a tree of game nodes. Nodes on trunk
// represent the actual game moves, and nodes on
// branches represent some variatations.
// The basic operation on a game is to play moves.
// Game uses rules to determine if move is legal
// or illegal.
class Game {
  GameNodeSequence _trunk;
  Rule rule;

  GameNodeSequence _currentSequence;
  int _currentNodeIndex;

  // default constructor creates a game with empty
  // board with default size, and uses default rules.
  Game() {
    _trunk = GameNodeSequence(null);
    GameNode rootNode = GameNode(owner: _trunk);
    _trunk.addNode(rootNode);
    rule = DefaultGoRule();

    _currentNodeIndex = 0;
    _currentSequence = _trunk;
  }

  makeMove(Stone stone, Vertex v) {
    GameNode newNode = rule.tryMakeMove(_currentSequence, stone, v);
    if (newNode != null) {
      _currentNodeIndex = _currentSequence.addNode(newNode);
    }
  }

  forceMove(Stone stone, Vertex v) {

  }

  GameNode get currentNode {
    return _currentSequence.nodeAt(_currentNodeIndex);
  }

}