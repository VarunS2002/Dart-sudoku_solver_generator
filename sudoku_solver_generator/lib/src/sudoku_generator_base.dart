import 'package:sudoku_solver_generator/src/sudoku_exceptions_base.dart';
import 'package:sudoku_solver_generator/src/sudoku_utilities_base.dart';

/// Provides the functionality of generating Sudoku puzzles.
///
/// This class has to be instantiated for every new puzzle.
class SudokuGenerator {
  /// Constructor to generate the Sudoku. Use the getter methods to retrieve
  /// the puzzle.
  ///
  /// [emptySquares] specifies how many boxes should be left empty in the
  /// unsolved puzzle. Clues will be 81-[emptySquares].
  /// Defaults to `27`.
  /// Higher difficulty is indicated by more [emptySquares].
  ///
  /// Suggested values for various difficulty levels:
  /// * Beginner - 18
  /// * Easy - 27
  /// * Medium - 36
  /// * Hard - 54
  ///
  /// [uniqueSolution] specifies if the required Sudoku must have
  /// only 1 solution.
  /// Defaults to `true`.
  ///
  ///
  /// [InvalidEmptySquaresException] is thrown if the value of [emptySquares]
  /// is invalid.
  /// Valid values: Any integer from 1-81 (inclusive).
  ///
  /// [UnlikelyUniqueSolutionException] is thrown if [emptySquares] is `> 54`
  /// when [uniqueSolution] is `true`.
  /// This is because a unique solution is unlikely if there are less than
  /// `27` clues.
  SudokuGenerator({int emptySquares = 27, bool uniqueSolution = true}) {
    if (emptySquares < 1) {
      throw InvalidEmptySquaresException();
    }
    if (uniqueSolution) {
      if (emptySquares > 54) {
        throw UnlikelyUniqueSolutionException();
      }
    } else {
      if (emptySquares > 81) {
        throw InvalidEmptySquaresException();
      }
    }
    _uniqueSolution = uniqueSolution;
    _emptySquares = emptySquares;
    _sudoku = List.generate(9, (i) => List.generate(9, (j) => 0));
    _fillValues();
  }

  late bool _uniqueSolution;
  late int _emptySquares;
  late List<List<int>> _sudoku;
  late List<List<int>> _sudokuSolved;

  /// Unsolved Sudoku with the specified [emptySquares].
  List<List<int>> get newSudoku => _sudoku;

  /// 1 possible solution of the unsolved Sudoku if [uniqueSolution] is `false`
  /// else the only solution.
  ///
  /// When [uniqueSolution] is `false` use [SudokuUtilities.isSolved()] to
  /// check if a game is solved instead of comparing with this.
  /// This is to prevent false-negatives when a puzzle has been solved
  /// correctly but the solution is not identical to this one.
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
      if (_uniqueSolution) {
        var backup = _sudoku[row][column];
        _sudoku[row][column] = 0;
        if (SudokuUtilities.hasUniqueSolution(_sudoku)) {
          _emptySquares--;
        } else {
          _sudoku[row][column] = backup;
        }
      } else {
        _sudoku[row][column] = 0;
        _emptySquares--;
      }
    }
  }
}
