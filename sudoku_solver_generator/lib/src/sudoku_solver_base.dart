import 'package:sudoku_solver_generator/src/sudoku_utilities_base.dart';

///
class SudokuSolver {
  static List<List<int>> solve(List<List<int?>> sudoku) {
    var _solvedGrid = SudokuUtilities.makeNullSafe(sudoku);
    _solveImplementation(_solvedGrid);
    return _solvedGrid;
  }

  static List<int>? _findEmpty(List<List<int>> sudoku) {
    for (var i = 0; i < 9; i++) {
      for (var j = 0; j < 9; j++) {
        if (sudoku[i][j] == 0) {
          return [i, j];
        }
      }
    }
    return null;
  }

  static bool _valid(List<List<int>> sudoku, int number, List<int> position) {
    for (var i = 0; i < 9; i++) {
      if (sudoku[position[0]][i] == number && position[1] != i) {
        return false;
      }
    }
    for (var i = 0; i < 9; i++) {
      if (sudoku[i][position[1]] == number && position[0] != i) {
        return false;
      }
    }
    var boxX = position[1] ~/ 3;
    var boxY = position[0] ~/ 3;
    for (var i = boxY * 3; i < boxY * 3 + 3; i++) {
      for (var j = boxX * 3; j < boxX * 3 + 3; j++) {
        if (sudoku[i][j] == number && [i, j] != position) {
          return false;
        }
      }
    }
    return true;
  }

  static bool _solveImplementation(List<List<int>> sudoku) {
    int row;
    int column;
    if (_findEmpty(sudoku) == null) {
      return true;
    } else {
      row = _findEmpty(sudoku)![0];
      column = _findEmpty(sudoku)![1];
    }
    for (var i = 1; i < 10; i++) {
      if (_valid(sudoku, i, [row, column])) {
        sudoku[row][column] = i;
        if (_solveImplementation(sudoku)) {
          return true;
        }
        sudoku[row][column] = 0;
      }
    }
    return false;
  }
}
