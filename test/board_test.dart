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
}
