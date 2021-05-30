///
class SudokuSolver {
  late List<List<int>> _solvedGrid;
  int _counter = 0;

  SudokuSolver(List<List<int?>> grid) {
    // TODO: Allow accepting and returning 1D Lists
    _solvedGrid = _replaceNullWithZero(grid);
    _solve(_solvedGrid);
  }

  List<List<int>> get solution {
    return _solvedGrid;
  }

  int get noOfSolutions {
    return _counter;
  }

  List<List<int>> _replaceNullWithZero(List<List<int?>> grid) {
    var notNullGrid = List.generate(9, (i) => List.generate(9, (j) => 0));
    for (var i = 0; i < 9; i++) {
      for (var j = 0; j < 9; j++) {
          notNullGrid[i][j] = grid[i][j] ?? 0;
      }
    }
    return notNullGrid;
  }

  List<int>? _findEmpty(List<List<int>> grid) {
    for (var i = 0; i < 9; i++) {
      for (var j = 0; j < 9; j++) {
        if (grid[i][j] == 0) {
          return [i, j];
        }
      }
    }
    return null;
  }

  bool _valid(List<List<int>> grid, int num, List<int> pos) {
    for (var i = 0; i < 9; i++) {
      if (grid[pos[0]][i] == num && pos[1] != i) {
        return false;
      }
    }
    for (var i = 0; i < 9; i++) {
      if (grid[i][pos[1]] == num && pos[0] != i) {
        return false;
      }
    }
    var boxX = pos[1] ~/ 3;
    var boxY = pos[0] ~/ 3;
    for (var i = boxY * 3; i < boxY * 3 + 3; i++) {
      for (var j = boxX * 3; j < boxX * 3 + 3; j++) {
        if (grid[i][j] == num && [i, j] != pos) {
          return false;
        }
      }
    }
    return true;
  }

  bool _solve(List<List<int>> grid) {
    int row;
    int col;
    if (_findEmpty(grid) == null) {
      _counter++;
      return true;
    } else {
      row = _findEmpty(grid)![0];
      col = _findEmpty(grid)![1];
    }
    for (var i = 1; i < 10; i++) {
      if (_valid(grid, i, [row, col])) {
        grid[row][col] = i;
        if (_solve(grid)) {
          return true;
        }
        grid[row][col] = 0;
      }
    }
    return false;
  }
}
