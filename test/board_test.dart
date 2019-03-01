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
      Set<Vertex> chain = board.chainFrom(Vertex.withXY(15, 15));
      expect(chain.length, equals(1));
      expect(chain.contains(Vertex.withXY(15, 15)), true);
    });

    test('A few stones in center', () {
      Set<Vertex> blackChain = board.chainFrom(Vertex.withXY(2, 3));
      expect(blackChain.length, equals(4));
      expect(blackChain.contains(Vertex.withXY(2, 3)), true);
      expect(blackChain.contains(Vertex.withXY(3, 3)), true);
      expect(blackChain.contains(Vertex.withXY(4, 3)), true);
      expect(blackChain.contains(Vertex.withXY(5, 3)), true);

      Set<Vertex> whiteChain = board.chainFrom(Vertex.withXY(2, 2));
      expect(whiteChain.length, equals(4));
      expect(whiteChain.contains(Vertex.withXY(2, 2)), true);
      expect(whiteChain.contains(Vertex.withXY(3, 2)), true);
      expect(whiteChain.contains(Vertex.withXY(4, 2)), true);
      expect(whiteChain.contains(Vertex.withXY(5, 2)), true);
    });

    test('A few stones in corner', () {
      Set<Vertex> blackChain = board.chainFrom(Vertex.withXY(17, 17));
      expect(blackChain.length, equals(4));
      expect(blackChain.contains(Vertex.withXY(17, 17)), true);
      expect(blackChain.contains(Vertex.withXY(18, 18)), true);
      expect(blackChain.contains(Vertex.withXY(17, 18)), true);
      expect(blackChain.contains(Vertex.withXY(18, 17)), true);
    });

    test('A circle in center', () {
      Set<Vertex> chain = board.chainFrom(Vertex.withXY(9, 9));
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

  group('Liberties', () {
    Board board;

    setUp(() {
      board = new Board()
        // single in center
        ..placeStoneAt(Stone.Black, Vertex.withXY(15, 15))
        // two adjacent chains
        ..placeStoneAt(Stone.Black, Vertex.withXY(2, 3))
        ..placeStoneAt(Stone.Black, Vertex.withXY(3, 3))
        ..placeStoneAt(Stone.Black, Vertex.withXY(4, 3))
        ..placeStoneAt(Stone.Black, Vertex.withXY(5, 3))
        ..placeStoneAt(Stone.White, Vertex.withXY(2, 2))
        ..placeStoneAt(Stone.White, Vertex.withXY(3, 2))
        ..placeStoneAt(Stone.White, Vertex.withXY(4, 2))
        ..placeStoneAt(Stone.White, Vertex.withXY(5, 2))
        // a 2x2 square in corner
        ..placeStoneAt(Stone.Black, Vertex.withXY(18, 18))
        ..placeStoneAt(Stone.Black, Vertex.withXY(18, 17))
        ..placeStoneAt(Stone.Black, Vertex.withXY(17, 18))
        ..placeStoneAt(Stone.Black, Vertex.withXY(17, 17))
        // a white circle in center
        ..placeStoneAt(Stone.White, Vertex.withXY(9, 9))
        ..placeStoneAt(Stone.White, Vertex.withXY(10, 9))
        ..placeStoneAt(Stone.White, Vertex.withXY(11, 9))
        ..placeStoneAt(Stone.White, Vertex.withXY(9, 11))
        ..placeStoneAt(Stone.White, Vertex.withXY(10, 11))
        ..placeStoneAt(Stone.White, Vertex.withXY(11, 11))
        ..placeStoneAt(Stone.White, Vertex.withXY(9, 10))
        ..placeStoneAt(Stone.White, Vertex.withXY(11, 10))
        // a black circle surrounds the white one
        ..placeStoneAt(Stone.Black, Vertex.withXY(9, 8))
        ..placeStoneAt(Stone.Black, Vertex.withXY(10, 8))
        ..placeStoneAt(Stone.Black, Vertex.withXY(11, 8))
        ..placeStoneAt(Stone.Black, Vertex.withXY(12, 8))
        ..placeStoneAt(Stone.Black, Vertex.withXY(12, 9))
        ..placeStoneAt(Stone.Black, Vertex.withXY(12, 10))
        ..placeStoneAt(Stone.Black, Vertex.withXY(12, 11))
        ..placeStoneAt(Stone.Black, Vertex.withXY(12, 12))
        ..placeStoneAt(Stone.Black, Vertex.withXY(11, 12))
        ..placeStoneAt(Stone.Black, Vertex.withXY(10, 12))
        ..placeStoneAt(Stone.Black, Vertex.withXY(9, 12))
        ..placeStoneAt(Stone.Black, Vertex.withXY(8, 12))
        ..placeStoneAt(Stone.Black, Vertex.withXY(8, 11))
        ..placeStoneAt(Stone.Black, Vertex.withXY(8, 10))
        ..placeStoneAt(Stone.Black, Vertex.withXY(8, 9))
        ..placeStoneAt(Stone.Black, Vertex.withXY(8, 8));
    });

    test('Black with adjacent white in center', () {
      Set<Vertex> liberties = board.libertiesFrom(Vertex.withXY(2, 3));
      expect(liberties.length, equals(6));
      expect(liberties.toSet().containsAll([
        Vertex.withXY(1, 3),
        Vertex.withXY(6, 3),
        Vertex.withXY(2, 4),
        Vertex.withXY(3, 4),
        Vertex.withXY(4, 4),
        Vertex.withXY(5, 4),
      ]), true);
    });

    test('White with adjacent black in center', () {
      Set<Vertex> liberties = board.libertiesFrom(Vertex.withXY(2, 2));
      expect(liberties.length, equals(6));
      expect(liberties.toSet().containsAll([
        Vertex.withXY(1, 2),
        Vertex.withXY(6, 2),
        Vertex.withXY(2, 1),
        Vertex.withXY(3, 1),
        Vertex.withXY(4, 1),
        Vertex.withXY(5, 1),
      ]), true);
    });

    test('Square In corner', () {
      Set<Vertex> liberties = board.libertiesFrom(Vertex.withXY(17, 17));
      expect(liberties.length, equals(4));
      expect(liberties.toSet().containsAll([
        Vertex.withXY(17, 16),
        Vertex.withXY(18, 16),
        Vertex.withXY(16, 17),
        Vertex.withXY(16, 18),
      ]), true);
    });

    test('Inner circle in center', () {
      Set<Vertex> liberties = board.libertiesFrom(Vertex.withXY(9, 9));
      expect(liberties.length, equals(1));
      expect(liberties.contains(Vertex.withXY(10, 10)), true);
    });
  
    test('outer circle In corner', () {
      Set<Vertex> liberties = board.libertiesFrom(Vertex.withXY(8, 8));
      expect(liberties.length, equals(20));
    });
  });
}
