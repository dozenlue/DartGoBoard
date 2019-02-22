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
      expect(board.stoneAt(10, 10), equals(Stone.None));
      expect(board.stoneAt(0, 0), equals(Stone.None));
      expect(board.stoneAt(18, 18), equals(Stone.None));
    });
  });

  group('Board status with default size', () {
    Board board;

    setUp(() {
      board = new Board()
        ..placeStoneAt(Stone.Black, 2, 3)
        ..placeStoneAt(Stone.White, 16, 15)
        ..placeStoneAt(Stone.Black, 9, 9);
    });

    test('no stone', () {
      expect(board.stoneAt(5, 5), equals(Stone.None));
      expect(board.stoneAt(15, 15), equals(Stone.None));
    });

    test('has stone', () {
      expect(board.stoneAt(2, 3), equals(Stone.Black));
      expect(board.stoneAt(9, 9), equals(Stone.Black));
      expect(board.stoneAt(16,15), equals(Stone.White));
    });

    test('remove stone', () {
      expect(board.stoneAt(9, 9), equals(Stone.Black));
      board.placeStoneAt(Stone.None, 9, 9);
      expect(board.stoneAt(9, 9), equals(Stone.None));
    });

    test('compare', () {
      Board anotherBoard = Board()
        ..placeStoneAt(Stone.White, 16, 15)
        ..placeStoneAt(Stone.Black, 2, 3)
        ..placeStoneAt(Stone.Black, 9, 9);
      expect(anotherBoard, equals(board));

      Board yetAnotherBoard = Board()
        ..placeStoneAt(Stone.White, 15, 16)
        ..placeStoneAt(Stone.Black, 3, 2)
        ..placeStoneAt(Stone.Black, 9, 9);
      expect(yetAnotherBoard, isNot(equals(Stone.None)));
    });
  });
}
