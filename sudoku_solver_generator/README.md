# Dart-sudoku_solver_generator

A Dart library containing tools related to Sudoku puzzles. This includes generating, solving and handling puzzles.

> [![Latest_Release](https://img.shields.io/pub/v/sudoku_solver_generator)](https://pub.dev/packages/sudoku_solver_generator)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

## [Changelog](https://github.com/VarunS2002/Dart-sudoku_solver_generator/blob/main/sudoku_solver_generator/CHANGELOG.md)

## Usage

```yaml
dependencies:
  sudoku_solver_generator: ^2.1.0
```

A Sudoku Solver usage example:

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
  var sudokuSolved = SudokuSolver.solve(sudoku);
  SudokuUtilities.printSudoku(sudokuSolved);
}
```

A Sudoku Generator usage example:

```dart
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

main() {
  var sudokuGenerator = SudokuGenerator(emptySquares: 54);
  SudokuUtilities.printSudoku(sudokuGenerator.newSudoku);
  print('');
  SudokuUtilities.printSudoku(sudokuGenerator.newSudokuSolved, animated: true);
}
```

<br>

> ### Sudoku game based on this package: [Flutter-Sudoku](https://github.com/VarunS2002/Flutter-Sudoku/)

## Features

- Generate Sudoku puzzles with your specified number of empty squares or clues.

- Option to specify if the required Sudoku should have a unique solution.

- Solve Sudoku puzzles of any difficulty instantly.

- Check if the Sudoku puzzle (unsolved or solved) is valid in terms of game rules.

- Check if the Sudoku puzzle has been solved properly.

- Check if the unsolved Sudoku has a unique solution.

- Convert the Data Structure of the Sudoku puzzle from a 2D List to 1D List and vice-versa.

- Print Sudoku puzzles to the console in an easy-to-read manner.

- Well documented client code.

## Note

- Referred Algorithms:

    - [Sudoku Generation Algorithm](https://www.geeksforgeeks.org/program-sudoku-generator/) in Java.

    - [Solving Algorithm](https://www.101computing.net/sudoku-generator-algorithm/) in Python.

    - [Sudoku Validation](https://www.geeksforgeeks.org/check-if-given-sudoku-board-configuration-is-valid-or-not/) in
      Python.

    - [Unique Solution Checking](https://github.com/ngbaanh/unique-solution-sudoku-generator) in C.

- If you face any issue or have suggestions then feel free to open an issue on GitHub.
