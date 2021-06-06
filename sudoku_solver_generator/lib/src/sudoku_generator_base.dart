import 'package:sudoku_solver_generator/src/sudoku_exceptions_base.dart';
import 'package:sudoku_solver_generator/src/sudoku_utilities_base.dart';

/// Provides the functionality of generating Sudoku puzzles.
///
/// This class has to be instantiated for every new puzzle.
class SudokuGenerator {
  /// Constructor to generate the Sudoku. Use the getter methods to retrieve
  /// the puzzle.
  ///
  /// [_emptySquares] specifies how many boxes should be left empty in the
  /// unsolved puzzle. Clues will be 81-[_emptySquares].
  /// Defaults to 27.
  /// Higher difficulty is indicated by more [_emptySquares].
  ///
  /// Suggested values for various difficulty levels:
  /// * Beginner - 18
  /// * Easy - 27
  /// * Medium - 36
  /// * Hard - 54
  ///
  /// [InvalidEmptySquaresException] is thrown if the value of [_emptySquares]
  /// is invalid.
  /// Valid values: Any integer from 1-81 (inclusive).
  /// (Known Issue - May generate puzzles with more than 1 solution.
  /// More likely with high [_emptySquares]).
  SudokuGenerator([this._emptySquares = 27]) {
    if (_emptySquares < 1 || _emptySquares > 81) {
      throw InvalidEmptySquaresException();
    }
    _sudoku = List.generate(9, (i) => List.generate(9, (j) => 0));
    _fillValues();
  }

  late int _emptySquares;
  late List<List<int>> _sudoku;
  late List<List<int>> _sudokuSolved;

  /// Unsolved Sudoku with the specified [_emptySquares].
  List<List<int>> get newSudoku => _sudoku;

  /// 1 possible solution of the unsolved Sudoku.
  ///
  /// Use [SudokuUtilities.isSolved()] instead of this to check if a game is
  /// solved instead of comparing with this.
  /// This is to prevent false-negatives when a puzzle has more than
  /// one solution.
  List<List<int>> get newSudokuSolved => _sudokuSolved;

  void _fillValues() {
    _fillDiagonal();
    _fillRemaining(0, 3);
    _sudokuSolved = SudokuUtilities.copySudoku(_sudoku);
    _removeClues();
  }

  void _fillDiagonal() {
    for (var i = 0; i < 9; i = i + 3) {
      _fillBox(i, i);
    }
  }

  void _fillBox(int row, int column) {
    int number;
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        do {
          number = _randomGenerator();
        } while (!_unUsedInBox(row, column, number));
        _sudoku[row + i][column + j] = number;
      }
    }
  }

  bool _unUsedInBox(int rowStart, int columnStart, int number) {
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (_sudoku[rowStart + i][columnStart + j] == number) {
          return false;
        }
      }
    }
    return true;
  }

  static int _randomGenerator() {
    var numberList = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9]..shuffle();
    return numberList[0];
  }

  bool _checkIfSafe(int i, int j, int number) =>
      (_unUsedInRow(i, number) && _unUsedInColumn(j, number)) &&
      _unUsedInBox(i - (i % 3), j - (j % 3), number);

  bool _unUsedInRow(int i, int number) {
    for (var j = 0; j < 9; j++) {
      if (_sudoku[i][j] == number) {
        return false;
      }
    }
    return true;
  }

  bool _unUsedInColumn(int j, int number) {
    for (var i = 0; i < 9; i++) {
      if (_sudoku[i][j] == number) {
        return false;
      }
    }
    return true;
  }

  bool _fillRemaining(int i, int j) {
    if ((j >= 9) && (i < (9 - 1))) {
      i = i + 1;
      j = 0;
    }
    if ((i >= 9) && (j >= 9)) {
      return true;
    }
    if (i < 3) {
      if (j < 3) {
        j = 3;
      }
    } else {
      if (i < (9 - 3)) {
        if (j == ((i ~/ 3) * 3)) {
          j = j + 3;
        }
      } else {
        if (j == (9 - 3)) {
          i = i + 1;
          j = 0;
          if (i >= 9) {
            return true;
          }
        }
      }
    }
    for (var number = 1; number <= 9; number++) {
      if (_checkIfSafe(i, j, number)) {
        _sudoku[i][j] = number;
        if (_fillRemaining(i, j + 1)) {
          return true;
        }
        _sudoku[i][j] = 0;
      }
    }
    return false;
  }

  void _removeClues() {
    while (_emptySquares > 0) {
      var row = _randomGenerator() - 1;
      var column = _randomGenerator() - 1;
      while (_sudoku[row][column] == 0) {
        row = _randomGenerator() - 1;
        column = _randomGenerator() - 1;
      }
      _sudoku[row][column] = 0;
      _emptySquares--;
    }
  }
}
