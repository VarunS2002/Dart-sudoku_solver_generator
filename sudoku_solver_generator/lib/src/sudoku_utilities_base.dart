///
class SudokuUtilities {
  static void printSudoku(List<List<int>> sudoku) {
    for (var row in sudoku) {
      print(row);
    }
  }

  static List<List<int>> copySudoku(List<List<int>> sudoku) {
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
    return nullSafeSudoku;
  }

  static List<int> to1D(List<List<int>> sudoku) {
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
    return sudoku2D;
  }
}
