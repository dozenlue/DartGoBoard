import 'dart:core';
import 'dart:typed_data';

// Stone status of a given cross
enum Stone { None, Black, White }

// Board simply represents a go game board.
// Support place/remove white/black stones,
// without any game rule consideration.
class Board {
  static const int defaultBoardSize = 19;

  static UnmodifiableUint64ListView _stoneMask = UnmodifiableUint64ListView(Uint64List.fromList([
    0x8000000000000000, 0x2000000000000000,
    0x0800000000000000, 0x0200000000000000,
    0x0080000000000000, 0x0020000000000000,
    0x0008000000000000, 0x0002000000000000,
    0x0000800000000000, 0x0000200000000000,
    0x0000080000000000, 0x0000020000000000,
    0x0000008000000000, 0x0000002000000000,
    0x0000000800000000, 0x0000000200000000,
    0x0000000080000000, 0x0000000020000000,
    0x0000000008000000, 0x0000000002000000,
    0x0000000000800000, 0x0000000000200000,
    0x0000000000080000, 0x0000000000020000,
    0x0000000000008000, 0x0000000000002000,
    0x0000000000000800, 0x0000000000000200,
    0x0000000000000080, 0x0000000000000020,
    0x0000000000000008, 0x0000000000000002,
  ]));

  static UnmodifiableUint64ListView _colorMask = UnmodifiableUint64ListView(Uint64List.fromList([
    0x4000000000000000, 0x1000000000000000,
    0x0400000000000000, 0x0100000000000000,
    0x0040000000000000, 0x0010000000000000,
    0x0004000000000000, 0x0001000000000000,
    0x0000400000000000, 0x0000100000000000,
    0x0000040000000000, 0x0000010000000000,
    0x0000004000000000, 0x0000001000000000,
    0x0000000400000000, 0x0000000100000000,
    0x0000000040000000, 0x0000000010000000,
    0x0000000004000000, 0x0000000001000000,
    0x0000000000400000, 0x0000000000100000,
    0x0000000000040000, 0x0000000000010000,
    0x0000000000004000, 0x0000000000001000,
    0x0000000000000400, 0x0000000000000100,
    0x0000000000000040, 0x0000000000000010,
    0x0000000000000004, 0x0000000000000001,
  ]));

  // to define a square board, need to provide an integer
  // between 1 to 32
  int boardSize;

  // Use a list of 64-bit integer to store board status
  Uint64List _rows;

  // default constructor creates an empty board
  Board({int size = defaultBoardSize})
    : boardSize = size {
    _rows = Uint64List(size)
      ..setAll(0, Iterable.generate(size, (x) => 0));
  }

  // copy from an exsiting board
  Board.fromBoard(Board board) {
    this.boardSize = board.boardSize;
    this._rows = Uint64List.fromList(board._rows);
  }

  // To get board status at given coordinate (x, y)
  Stone stoneAt(int x, int y) {
    _assertValid(x, y);

    if (_hasStone(x, y)) {
      return _isWhite(x, y) ? Stone.White : Stone.Black;
    }

    return Stone.None;
  }

  _assertValid(int x, int y) {
    if (x < 0 || x >= boardSize) {
      throw RangeError.range(x, 0, boardSize -1, "x out of board range");
    }

    if (y < 0 || y >= boardSize) {
      throw RangeError.range(y, 0, boardSize -1, "y out of board range");
    }
  }

  bool _hasStone(int x, int y) {
    return this._rows[y] & _stoneMask[x] != 0;
  }

  bool _isWhite(int x, int y) {
    return this._rows[y] & _colorMask[x] != 0;
  }

  // Place a stone. A [Stone.None] means removing
  placeStoneAt(Stone stone, int x, int y) {
    _assertValid(x, y);

    switch (stone) {
      case Stone.None:
        _removeStone(x, y);
        _markBlackStone(x, y);
        break;
      case Stone.White:
        _placeStone(x, y);
        _markWhiteStone(x, y);
        break;
      case Stone.Black:
        _placeStone(x, y);
        _markBlackStone(x, y);
        break;
      default:
        throw ArgumentError.value(stone, "Invalid stone value");
    }
  }

  _removeStone(int x, int y) {
    this._rows[y] &= ~(_stoneMask[x]);
  }

  _placeStone(int x, int y) {
    this._rows[y] |= _stoneMask[x];
  }

  _markWhiteStone(int x, int y) {
    this._rows[y] |= _colorMask[x];
  }

  _markBlackStone(int x, int y) {
    this._rows[y] &= ~(_colorMask[x]);
  }

  @override
  int get hashCode {
    int shift = 64 - boardSize * 2;
    int result = 0;
    for (int i=0; i<boardSize; i++) {
      result ^= _rows[i] >> shift;
    };

    return result;
  }

  @override
  bool operator ==(dynamic other) {
    if (other is! Board) {
      return false;
    }

    Board board =other;
    if (board.boardSize !=boardSize) {
      return false;
    }

    int shift = 64 - boardSize * 2;
    for (int i=0; i<boardSize; i++) {
      if (_rows[i] >> shift != board._rows[i] >> shift) {
        return false;
      }
    }

    return true;
  }
}