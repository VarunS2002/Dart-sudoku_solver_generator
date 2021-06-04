# Dart-sudoku_solver_generator

A Dart library to generate and/or solve Sudoku puzzles.

## Usage

* A Sudoku Solver usage example:

    ```dart
    import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';
    
    main() {
      var sudoku = <List<int?>>[
        [2, 1, 7, 4, 3, 5, 9, null, 8],
        [5, 8, 9, 0, 6, 2, 4, 3, null],
        [3, 4, 6, 0, 7, 9, 2, 5, 1],
        [1, 6, 2, 3, 0, 0, 5, 4, 0],
        [9, 0, 5, 2, 0, 4, 7, 8, 6],
        [4, 7, 8, 5, 9, 6, 1, 0, 0],
        [8, 0, 3, 0, 4, 1, 6, 7, 2],
        [0, 9, 4, 7, 2, 3, 8, 1, 5],
        [7, 2, 1, 0, 5, 0, 0, 0, 4],
      ];
      var sudokuSolved = SudokuSolver().solve(sudoku);
      SudokuUtilities.printSudoku(sudokuSolved);
    }
    ```
* A Sudoku Generator usage example:

    ```dart
    import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';
    
    main() {
      var sudokuGenerator = SudokuGenerator(54);
      SudokuUtilities.printSudoku(sudokuGenerator.newSudoku);
      print('');
      SudokuUtilities.printSudoku(sudokuGenerator.newSudokuSolved);
    }
    ```
