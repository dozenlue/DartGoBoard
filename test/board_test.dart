import 'package:board/board.dart';
import 'package:test/test.dart';

void main() {
  group('Empty board with default size: ', () {
    Board board;

    setUp(() {
      board = new Board();
    });

    test('board size', () {
      expect(board.boardSize, equals(19));
    });

    test('board status', () {
      expect(board.stoneAt(Vertex.withXY(10, 10)), equals(Stone.None));
      expect(board.stoneAt(Vertex.withXY(0, 0)), equals(Stone.None));
      expect(board.stoneAt(Vertex.withXY(18, 18)), equals(Stone.None));
    });
  });

  group('Board status with default size', () {
    Board board;

    setUp(() {
      board = new Board()
        ..placeStoneAt(Stone.Black, Vertex.withXY(2, 3))
        ..placeStoneAt(Stone.White, Vertex.withXY(16, 15))
        ..placeStoneAt(Stone.Black, Vertex.withXY(9, 9));
    });

    test('no stone', () {
      expect(board.stoneAt(Vertex.withXY(5, 5)), equals(Stone.None));
      expect(board.stoneAt(Vertex.withXY(15, 15)), equals(Stone.None));
    });

    test('has stone', () {
      expect(board.stoneAt(Vertex.withXY(2, 3)), equals(Stone.Black));
      expect(board.stoneAt(Vertex.withXY(9, 9)), equals(Stone.Black));
      expect(board.stoneAt(Vertex.withXY(16,15)), equals(Stone.White));
    });

    test('remove stone', () {
      expect(board.stoneAt(Vertex.withXY(9, 9)), equals(Stone.Black));
      board.placeStoneAt(Stone.None, Vertex.withXY(9, 9));
      expect(board.stoneAt(Vertex.withXY(9, 9)), equals(Stone.None));
    });

    test('compare', () {
      Board anotherBoard = Board()
        ..placeStoneAt(Stone.White, Vertex.withXY(16, 15))
        ..placeStoneAt(Stone.Black, Vertex.withXY(2, 3))
        ..placeStoneAt(Stone.Black, Vertex.withXY(9, 9));
      expect(anotherBoard, equals(board));

      Board yetAnotherBoard = Board()
        ..placeStoneAt(Stone.White, Vertex.withXY(15, 16))
        ..placeStoneAt(Stone.Black, Vertex.withXY(3, 2))
        ..placeStoneAt(Stone.Black, Vertex.withXY(9, 9));
      expect(yetAnotherBoard, isNot(equals(Stone.None)));
    });
  });

  group('Chains', () {
    Board board;

    setUp(() {
      board = new Board()
        ..placeStoneAt(Stone.Black, Vertex.withXY(15, 15))
        ..placeStoneAt(Stone.Black, Vertex.withXY(2, 3))
        ..placeStoneAt(Stone.Black, Vertex.withXY(3, 3))
        ..placeStoneAt(Stone.Black, Vertex.withXY(4, 3))
        ..placeStoneAt(Stone.Black, Vertex.withXY(5, 3))
        ..placeStoneAt(Stone.White, Vertex.withXY(2, 2))
        ..placeStoneAt(Stone.White, Vertex.withXY(3, 2))
        ..placeStoneAt(Stone.White, Vertex.withXY(4, 2))
        ..placeStoneAt(Stone.White, Vertex.withXY(5, 2))
        ..placeStoneAt(Stone.Black, Vertex.withXY(18, 18))
        ..placeStoneAt(Stone.Black, Vertex.withXY(18, 17))
        ..placeStoneAt(Stone.Black, Vertex.withXY(17, 18))
        ..placeStoneAt(Stone.Black, Vertex.withXY(17, 17))
        ..placeStoneAt(Stone.White, Vertex.withXY(9, 9))
        ..placeStoneAt(Stone.White, Vertex.withXY(10, 9))
        ..placeStoneAt(Stone.White, Vertex.withXY(11, 9))
        ..placeStoneAt(Stone.White, Vertex.withXY(9, 11))
        ..placeStoneAt(Stone.White, Vertex.withXY(10, 11))
        ..placeStoneAt(Stone.White, Vertex.withXY(11, 11))
        ..placeStoneAt(Stone.White, Vertex.withXY(9, 10))
        ..placeStoneAt(Stone.White, Vertex.withXY(11, 10));
    });

    test('A single stone in center', () {
      List<Vertex> chain = board.chainFrom(Vertex.withXY(15, 15));
      expect(chain.length, equals(1));
      expect(chain[0], equals(Vertex.withXY(15, 15)));
    });

    test('A few stones in center', () {
      List<Vertex> blackChain = board.chainFrom(Vertex.withXY(2, 3));
      expect(blackChain.length, equals(4));
      expect(blackChain.contains(Vertex.withXY(2, 3)), true);
      expect(blackChain.contains(Vertex.withXY(3, 3)), true);
      expect(blackChain.contains(Vertex.withXY(4, 3)), true);
      expect(blackChain.contains(Vertex.withXY(5, 3)), true);

      List<Vertex> whiteChain = board.chainFrom(Vertex.withXY(2, 2));
      expect(whiteChain.length, equals(4));
      expect(whiteChain.contains(Vertex.withXY(2, 2)), true);
      expect(whiteChain.contains(Vertex.withXY(3, 2)), true);
      expect(whiteChain.contains(Vertex.withXY(4, 2)), true);
      expect(whiteChain.contains(Vertex.withXY(5, 2)), true);
    });

    test('A few stones in corner', () {
      List<Vertex> blackChain = board.chainFrom(Vertex.withXY(17, 17));
      expect(blackChain.length, equals(4));
      expect(blackChain.contains(Vertex.withXY(17, 17)), true);
      expect(blackChain.contains(Vertex.withXY(18, 18)), true);
      expect(blackChain.contains(Vertex.withXY(17, 18)), true);
      expect(blackChain.contains(Vertex.withXY(18, 17)), true);
    });

    test('A circle in center', () {
      List<Vertex> chain = board.chainFrom(Vertex.withXY(9, 9));
      expect(chain.length, equals(8));
      expect(chain.contains(Vertex.withXY(9, 9)), true);
      expect(chain.contains(Vertex.withXY(10, 9)), true);
      expect(chain.contains(Vertex.withXY(11, 9)), true);
      expect(chain.contains(Vertex.withXY(9, 11)), true);
      expect(chain.contains(Vertex.withXY(10, 11)), true);
      expect(chain.contains(Vertex.withXY(11, 11)), true);
      expect(chain.contains(Vertex.withXY(9, 10)), true);
      expect(chain.contains(Vertex.withXY(11, 11)), true);
    });
    
  });
}
