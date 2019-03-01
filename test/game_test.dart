import 'package:test/test.dart';
import 'package:board/board.dart';

void main() {
  group('Empty Game: ', () {
    Game game;

    setUp(() {
      game = new Game();
    });

    test('root node', () {
      expect(game.currentNode, isNotNull);
    });

    test('make a move', () {
      game.makeMove(Stone.Black, Vertex.withXY(10, 10));
      expect(game.currentNode == game.rootNode, false);
      expect(game.currentNode.board.stoneAt(Vertex.withXY(10, 10)), equals(Stone.Black));
    });

    test('simple capture', () {
      game.makeMove(Stone.White, Vertex.withXY(10, 9));
      game.makeMove(Stone.Black, Vertex.withXY(10, 10));
      game.makeMove(Stone.White, Vertex.withXY(10, 11));
      game.makeMove(Stone.White, Vertex.withXY(9, 10));
      game.makeMove(Stone.White, Vertex.withXY(11, 10));

      expect(game.currentNode.board.stoneAt(Vertex.withXY(10, 10)), equals(Stone.None));
    });

    test('suicide', () {
      GameNode before = game.currentNode;
      game.makeMove(Stone.White, Vertex.withXY(10, 9));
      expect(game.currentNode, isNot(before));

      before = game.currentNode;
      game.makeMove(Stone.White, Vertex.withXY(10, 11));
      expect(game.currentNode, isNot(before));

      before = game.currentNode;
      game.makeMove(Stone.White, Vertex.withXY(9, 10));
      expect(game.currentNode, isNot(before));

      before = game.currentNode;
      game.makeMove(Stone.White, Vertex.withXY(11, 10));
      expect(game.currentNode, isNot(before));

      // suicide move is not valid
      before =game.currentNode;
      game.makeMove(Stone.Black, Vertex.withXY(10, 10));
      expect(game.currentNode, equals(before));
      expect(game.currentNode.board.stoneAt(Vertex.withXY(10, 10)), equals(Stone.None));
    });
  });
}