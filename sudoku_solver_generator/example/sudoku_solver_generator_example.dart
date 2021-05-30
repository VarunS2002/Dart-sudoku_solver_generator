import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

void main() {
  // Solve Example
  var grid = <List<int?>>[
    [7, null, 2, 0, 3, 0, 0, 6, 0],
    [0, 0, 0, 0, 0, 0, 0, 8, 0],
    [0, 4, 0, 0, 9, 0, 0, 0, 0],
    [0, 6, 7, 0, 1, 9, 0, 0, 5],
    [0, 5, 0, 2, 0, 3, 0, 0, 4],
    [0, 0, 0, 0, 5, 0, 7, 0, 0],
    [0, 3, 0, 7, 0, 0, 0, 5, 0],
    [0, 7, 0, 0, 0, 5, 0, 0, 0],
    [0, 0, 5, 0, 4, 0, 0, 7, 6]
  ];
  var sudokuSolver = SudokuSolver(grid);
  for (var row in sudokuSolver.solution) {
    print(row);
  }
}
