import 'package:sudoku_solver_generator/src/sudoku_utilities_base.dart';

///
class SudokuGenerator {
  final int N = 9;
  final int sqrN = 3;
  late int K;
  List<List<int>> mat = List.generate(9, (i) => List.generate(9, (j) => 0));
  List<List<int>> matSolved =
      List.generate(9, (i) => List.generate(9, (j) => 0));

  SudokuGenerator([int emptySquares = 27]) {
    K = emptySquares;
    _fillValues();
  }

  void _fillValues() {
    _fillDiagonal();
    _fillRemaining(0, sqrN);
    matSolved = SudokuUtilities.copySudoku(mat);
    _removeKDigits();
  }

  void _fillDiagonal() {
    for (var i = 0; i < N; (i = (i + sqrN))) {
      _fillBox(i, i);
    }
  }

  void _fillBox(int row, int col) {
    int num;
    for (var i = 0; i < sqrN; i++) {
      for (var j = 0; j < sqrN; j++) {
        do {
          num = _randomGenerator();
        } while (!_unUsedInBox(row, col, num));
        mat[row + i][col + j] = num;
      }
    }
  }

  bool _unUsedInBox(int rowStart, int colStart, int num) {
    for (var i = 0; i < sqrN; i++) {
      for (var j = 0; j < sqrN; j++) {
        if (mat[rowStart + i][colStart + j] == num) {
          return false;
        }
      }
    }
    return true;
  }

  static int _randomGenerator() {
    var numberList = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9];
    numberList.shuffle();
    return numberList[0];
  }

  bool _checkIfSafe(int i, int j, int num) {
    return (_unUsedInRow(i, num) && _unUsedInCol(j, num)) &&
        _unUsedInBox(i - (i % sqrN), j - (j % sqrN), num);
  }

  bool _unUsedInRow(int i, int num) {
    for (var j = 0; j < N; j++) {
      if (mat[i][j] == num) {
        return false;
      }
    }
    return true;
  }

  bool _unUsedInCol(int j, int num) {
    for (var i = 0; i < N; i++) {
      if (mat[i][j] == num) {
        return false;
      }
    }
    return true;
  }

  bool _fillRemaining(int i, int j) {
    if ((j >= N) && (i < (N - 1))) {
      i = (i + 1);
      j = 0;
    }
    if ((i >= N) && (j >= N)) {
      return true;
    }
    if (i < sqrN) {
      if (j < sqrN) {
        j = sqrN;
      }
    } else {
      if (i < (N - sqrN)) {
        if (j == ((i ~/ sqrN) * sqrN)) {
          j = (j + sqrN);
        }
      } else {
        if (j == (N - sqrN)) {
          i = (i + 1);
          j = 0;
          if (i >= N) {
            return true;
          }
        }
      }
    }
    for (var num = 1; num <= N; num++) {
      if (_checkIfSafe(i, j, num)) {
        mat[i][j] = num;
        if (_fillRemaining(i, j + 1)) {
          return true;
        }
        mat[i][j] = 0;
      }
    }
    return false;
  }

  void _removeKDigits() {
    while (K > 0) {
      var row = _randomGenerator() - 1;
      var col = _randomGenerator() - 1;
      while (mat[row][col] == 0) {
        row = _randomGenerator() - 1;
        col = _randomGenerator() - 1;
      }
      mat[row][col] = 0;
      K--;
    }
  }

  List<List<int>> get newSudoku {
    return mat;
  }

  List<List<int>> get newSudokuSolved {
    return matSolved;
  }
}
