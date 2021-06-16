import 'package:sudoku_solver_generator/src/sudoku_exceptions_base.dart';

/// Provides various functions related to using the Sudoku Solver and Generator
/// classes or handling the Sudoku puzzles.
///
/// Utility class which shouldn't be instantiated.
class SudokuUtilities {
  /// Prints the [sudoku] in a readable format to the console.
  /// Zeroes are represented as `-`.
  ///
  /// [InvalidSudokuConfigurationException] is thrown if the configuration of
  /// the [sudoku] is not valid.
  /// Example Format:
  /// ```
  /// 9  -  3   1  2  5   -  8  7
  /// 1  8  -   4  -  6   -  5  -
  /// 5  -  7   8  9  3   1  4  2
  ///
  /// 3  5  4   9  -  2   7  1  8
  /// 7  -  8   3  -  4   5  2  6
  /// 6  2  -   5  8  7   9  -  -
  ///
  /// 4  1  9   6  5  8   -  7  3
  /// 2  -  5   7  4  9   8  -  1
  /// 8  7  -   2  3  1   -  9  5
  /// ```
  static void printSudoku(List<List<int>> sudoku) {
    if (!isValidConfiguration(sudoku)) {
      throw InvalidSudokuConfigurationException();
    }
    var bufferToPrint = StringBuffer();
    for (var i = 0; i < 9; i++) {
      for (var j = 0; j < 9; j++) {
        if (sudoku[i][j] == 0) {
          bufferToPrint.write(j == 8 ? '-' : '-  ');
        } else {
          bufferToPrint.write('${sudoku[i][j]}${j == 8 ? '' : '  '}');
        }
        if (((j + 1) % 3 == 0) && !(j == 8)) {
          bufferToPrint.write(' ');
        }
        if (j == 8) {
          print(bufferToPrint); // ignore: avoid_print
          bufferToPrint.clear();
        }
      }
      if ((i + 1) % 3 == 0) {
        print(''); // ignore: avoid_print
      }
    }
  }

  /// Returns an identical copy of the provided [sudoku].
  ///
  /// [InvalidSudokuConfigurationException] is thrown if the configuration of
  /// the [sudoku] is not valid.
  static List<List<int>> copySudoku(List<List<int>> sudoku) {
    if (!isValidConfiguration(sudoku)) {
      throw InvalidSudokuConfigurationException();
    }
    var copiedSudoku = List.generate(9, (i) => List.generate(9, (j) => 0));
    for (var i = 0; i < 9; i++) {
      for (var j = 0; j < 9; j++) {
        copiedSudoku[i][j] = sudoku[i][j];
      }
    }
    return copiedSudoku;
  }

  /// Returns a null safe copy of provided [sudoku] to make it usable.
  ///
  /// Replaces `null` with `0` in the [sudoku].
  ///
  /// [InvalidSudokuConfigurationException] is thrown if the configuration of
  /// the [sudoku] is not valid.
  static List<List<int>> makeNullSafe(List<List<int?>> sudoku) {
    var nullSafeSudoku = List.generate(9, (i) => List.generate(9, (j) => 0));
    try {
      for (var i = 0; i < 9; i++) {
        for (var j = 0; j < 9; j++) {
          nullSafeSudoku[i][j] = sudoku[i][j] ?? 0;
        }
      }
    } on RangeError {
      throw InvalidSudokuConfigurationException();
    }
    if (!isValidConfiguration(nullSafeSudoku)) {
      throw InvalidSudokuConfigurationException();
    }
    return nullSafeSudoku;
  }

  /// Returns a copy of the provided [sudoku] as a 1 Dimensional [List].
  ///
  /// [InvalidSudokuConfigurationException] is thrown if the configuration of
  /// the [sudoku] is not valid.
  static List<int> to1D(List<List<int>> sudoku) {
    if (!isValidConfiguration(sudoku)) {
      throw InvalidSudokuConfigurationException();
    }
    var sudoku1D = List.generate(81, (i) => 0);
    var index = 0;
    for (var i = 0; i < 9; i++) {
      for (var j = 0; j < 9; j++) {
        sudoku1D[index] = sudoku[i][j];
        index++;
      }
    }
    return sudoku1D;
  }

  /// Returns a copy of the provided [sudoku] as a 2 Dimensional [List] which
  /// is the standard format.
  ///
  /// [InvalidSudokuConfigurationException] is thrown if the configuration of
  /// the [sudoku] is not valid.
  static List<List<int>> to2D(List<int> sudoku) {
    var sudoku2D = List.generate(9, (i) => List.generate(9, (j) => 0));
    var index = 0;
    try {
      for (var i = 0; i < 9; i++) {
        for (var j = 0; j < 9; j++) {
          sudoku2D[i][j] = sudoku[index];
          index++;
        }
      }
    } on RangeError {
      throw InvalidSudokuConfigurationException();
    }
    if (!isValidConfiguration(sudoku2D)) {
      throw InvalidSudokuConfigurationException();
    }
    return sudoku2D;
  }

  /// Returns `true` if the configuration of the [sudoku] follows the rules
  /// of Sudoku.
  ///
  /// Conditions:
  /// * [List] of 9 [List]s of 9 [int]s
  /// * Every row must have the numbers 1-9 without repetition
  /// * Every column must have the numbers 1-9 without repetition
  /// * Every 3x3 box must have the number 1-9 without repetition
  /// * Only positions of non-zero and non-null values are considered
  /// * Number of possible solutions of the puzzle is not considered
  static bool isValidConfiguration(List<List<int?>> sudoku) {
    bool notInRow(List<List<int?>> sudoku, int rowNumber) {
      var numberSet = <int>{};
      for (var i = 0; i < 9; i++) {
        if (numberSet.contains(sudoku[rowNumber][i])) {
          return false;
        } else if (sudoku[rowNumber][i] != 0 && sudoku[rowNumber][i] != null) {
          numberSet.add(sudoku[rowNumber][i]!);
        }
      }
      return true;
    }

    bool notInColumn(List<List<int?>> sudoku, int columnNumber) {
      var numberSet = <int>{};
      for (var i = 0; i < 9; i++) {
        if (numberSet.contains(sudoku[i][columnNumber])) {
          return false;
        } else if (sudoku[i][columnNumber] != 0 &&
            sudoku[i][columnNumber] != null) {
          numberSet.add(sudoku[i][columnNumber]!);
        }
      }
      return true;
    }

    bool notInBox(List<List<int?>> sudoku, int startRow, int startColumn) {
      var numberSet = <int>{};
      for (var row = 0; row < 3; row++) {
        for (var column = 0; column < 3; column++) {
          if (numberSet
              .contains(sudoku[row + startRow][column + startColumn])) {
            return false;
          } else if (sudoku[row + startRow][column + startColumn] != 0 &&
              sudoku[row + startRow][column + startColumn] != null) {
            numberSet.add(sudoku[row + startRow][column + startColumn]!);
          }
        }
      }
      return true;
    }

    bool isValid(List<List<int?>> sudoku, int rowNumber, int columnNumber) =>
        notInRow(sudoku, rowNumber) &&
        notInColumn(sudoku, columnNumber) &&
        notInBox(
            sudoku, rowNumber - rowNumber % 3, columnNumber - columnNumber % 3);

    bool containsValidValues(List<List<int?>> sudoku) {
      var validValueSet = <int?>{1, 2, 3, 4, 5, 6, 7, 8, 9, 0, null};
      for (var i = 0; i < 9; i++) {
        for (var j = 0; j < 9; j++) {
          if (!validValueSet.contains(sudoku[i][j])) {
            return false;
          }
        }
      }
      return true;
    }

    try {
      for (var i = 0; i < 9; i++) {
        for (var j = 0; j < 9; j++) {
          if (!isValid(sudoku, i, j)) {
            return false;
          }
        }
      }
    } on RangeError {
      return false;
    }

    if (!containsValidValues(sudoku)) {
      return false;
    }
    return true;
  }

  /// Returns `true` if the configuration of the [sudoku] is valid and there
  /// are no `0`s/empty squares.
  ///
  /// Recommended to use this to check if a game is solved instead of comparing
  /// with a solved sudoku.
  /// This is to prevent false-negatives when a puzzle has more than one
  /// solution.
  ///
  /// [InvalidSudokuConfigurationException] is thrown if the configuration of
  /// the [sudoku] is not valid.
  static bool isSolved(List<List<int>> sudoku) {
    if (!isValidConfiguration(sudoku)) {
      throw InvalidSudokuConfigurationException();
    }
    for (var i = 0; i < 9; i++) {
      if (sudoku[i].contains(0)) {
        return false;
      }
    }
    return true;
  }

  /// Returns `true` if the [sudoku] has only 1 solution.
  ///
  /// [InvalidSudokuConfigurationException] is thrown if the configuration of
  /// the [sudoku] is not valid.
  static bool hasUniqueSolution(List<List<int>> sudoku) {
    bool legal(List<List<int>> puzzle, int x, int y, int num) {
      var i = 9;
      var size = 9;
      var rowStart = x ~/ 3 * 3;
      var colStart = y ~/ 3 * 3;
      for (i = 0; i < size; i++) {
        if (puzzle[x][i] == num) {
          return false;
        }
        if (puzzle[i][y] == num) {
          return false;
        }
        if (puzzle[rowStart + (i % 3)][colStart + (i ~/ 3)] == num) {
          return false;
        }
      }
      return true;
    }

    int checkUniqueSolution(List<List<int>> puzzle, int x, int y, int count) {
      var num = 9;
      var size = 9;
      if (x == size) {
        x = 0;
        if (++y == size) {
          return 1 + count;
        }
      }
      if (puzzle[x][y] != 0) {
        return checkUniqueSolution(puzzle, x + 1, y, count);
      }
      for (num = 1; (num <= size) && (count < 2); num++) {
        if (legal(puzzle, x, y, num)) {
          puzzle[x][y] = num;
          count = checkUniqueSolution(puzzle, x + 1, y, count);
        }
      }
      puzzle[x][y] = 0;
      return count;
    }

    if (!isValidConfiguration(sudoku)) {
      throw InvalidSudokuConfigurationException();
    }
    return checkUniqueSolution(sudoku, 0, 0, 0) == 1;
  }
}
