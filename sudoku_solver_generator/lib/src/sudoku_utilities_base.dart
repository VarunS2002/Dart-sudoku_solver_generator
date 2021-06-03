import 'package:sudoku_solver_generator/src/sudoku_exceptions_base.dart';

///
class SudokuUtilities {
  static void printSudoku(List<List<int>> sudoku) {
    if (!isValidConfiguration(sudoku)) {
      throw InvalidSudokuConfigurationException();
    }
    for (var row in sudoku) {
      print(row);
    }
  }

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

  static List<List<int>> makeNullSafe(List<List<int?>> sudoku) {
    var nullSafeSudoku = List.generate(9, (i) => List.generate(9, (j) => 0));
    for (var i = 0; i < 9; i++) {
      for (var j = 0; j < 9; j++) {
        nullSafeSudoku[i][j] = sudoku[i][j] ?? 0;
      }
    }
    if (!isValidConfiguration(nullSafeSudoku)) {
      throw InvalidSudokuConfigurationException();
    }
    return nullSafeSudoku;
  }

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

  static List<List<int>> to2D(List<int> sudoku) {
    var sudoku2D = List.generate(9, (i) => List.generate(9, (j) => 0));
    var index = 0;
    for (var i = 0; i < 9; i++) {
      for (var j = 0; j < 9; j++) {
        sudoku2D[i][j] = sudoku[index];
        index++;
      }
    }
    if (!isValidConfiguration(sudoku2D)) {
      throw InvalidSudokuConfigurationException();
    }
    return sudoku2D;
  }

  static bool isValidConfiguration(List<List<int>> sudoku) {
    bool notInRow(List<List<int>> sudoku, int rowNumber) {
      var numberSet = <int>{};
      for (var i = 0; i < 9; i++) {
        if (numberSet.contains(sudoku[rowNumber][i])) {
          return false;
        } else if (sudoku[rowNumber][i] != 0) {
          numberSet.add(sudoku[rowNumber][i]);
        }
      }
      return true;
    }

    bool notInColumn(List<List<int>> sudoku, int columnNumber) {
      var numberSet = <int>{};
      for (var i = 0; i < 9; i++) {
        if (numberSet.contains(sudoku[i][columnNumber])) {
          return false;
        } else if (sudoku[i][columnNumber] != 0) {
          numberSet.add(sudoku[i][columnNumber]);
        }
      }
      return true;
    }

    bool notInBox(List<List<int>> sudoku, int startRow, int startColumn) {
      var numberSet = <int>{};
      for (var row = 0; row < 3; row++) {
        for (var column = 0; column < 3; column++) {
          if (numberSet
              .contains(sudoku[row + startRow][column + startColumn])) {
            return false;
          } else if (sudoku[row + startRow][column + startColumn] != 0) {
            numberSet.add(sudoku[row + startRow][column + startColumn]);
          }
        }
      }
      return true;
    }

    bool isValid(List<List<int>> sudoku, int rowNumber, int columnNumber) {
      return notInRow(sudoku, rowNumber) &&
          notInColumn(sudoku, columnNumber) &&
          notInBox(sudoku, rowNumber - rowNumber % 3,
              columnNumber - columnNumber % 3);
    }

    for (var i = 0; i < 9; i++) {
      for (var j = 0; j < 9; j++) {
        if (!isValid(sudoku, i, j)) {
          return false;
        }
      }
    }
    return true;
  }

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
}
