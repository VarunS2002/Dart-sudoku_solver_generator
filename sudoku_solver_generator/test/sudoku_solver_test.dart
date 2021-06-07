import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';
import 'package:test/test.dart';

void main() {
  group('SudokuSolver Tests', () {
    group('SudokuSolver solving tests', () {
      test('With null', () {
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
        expect(SudokuUtilities.isSolved(SudokuSolver.solve(sudoku)), isTrue);
      });

      test('Null safe', () {
        var sudoku = <List<int>>[
          [2, 1, 7, 4, 3, 5, 9, 0, 8],
          [5, 8, 9, 0, 6, 2, 4, 3, 0],
          [3, 4, 6, 0, 7, 9, 2, 5, 1],
          [1, 6, 2, 3, 0, 0, 5, 4, 0],
          [9, 0, 5, 2, 0, 4, 7, 8, 6],
          [4, 7, 8, 5, 9, 6, 1, 0, 0],
          [8, 0, 3, 0, 4, 1, 6, 7, 2],
          [0, 9, 4, 7, 2, 3, 8, 1, 5],
          [7, 2, 1, 0, 5, 0, 0, 0, 4],
        ];
        expect(SudokuUtilities.isSolved(SudokuSolver.solve(sudoku)), isTrue);
      });

      test('Already Solved', () {
        var sudoku = <List<int>>[
          [2, 1, 7, 4, 3, 5, 9, 6, 8],
          [5, 8, 9, 1, 6, 2, 4, 3, 7],
          [3, 4, 6, 8, 7, 9, 2, 5, 1],
          [1, 6, 2, 3, 8, 7, 5, 4, 9],
          [9, 3, 5, 2, 1, 4, 7, 8, 6],
          [4, 7, 8, 5, 9, 6, 1, 2, 3],
          [8, 5, 3, 9, 4, 1, 6, 7, 2],
          [6, 9, 4, 7, 2, 3, 8, 1, 5],
          [7, 2, 1, 6, 5, 8, 3, 9, 4],
        ];
        expect(SudokuUtilities.isSolved(SudokuSolver.solve(sudoku)), isTrue);
      });

      test('Easy - 27', () {
        var sudoku = <List<int>>[
          [2, 7, 0, 1, 0, 3, 8, 0, 5],
          [0, 0, 9, 2, 0, 8, 3, 0, 7],
          [3, 5, 0, 7, 0, 6, 0, 1, 4],
          [4, 0, 7, 8, 0, 5, 9, 3, 0],
          [5, 6, 0, 4, 3, 0, 7, 8, 1],
          [9, 0, 3, 0, 0, 1, 5, 0, 0],
          [7, 3, 4, 0, 6, 2, 0, 5, 0],
          [8, 2, 5, 3, 0, 4, 6, 7, 0],
          [6, 9, 1, 0, 0, 7, 4, 2, 3],
        ];
        expect(SudokuUtilities.isSolved(SudokuSolver.solve(sudoku)), isTrue);
      });

      test('Hard - 54', () {
        var sudoku = <List<int>>[
          [0, 6, 0, 1, 0, 0, 0, 0, 0],
          [0, 8, 0, 0, 0, 0, 0, 0, 1],
          [0, 0, 0, 0, 9, 5, 0, 4, 6],
          [0, 0, 0, 0, 6, 1, 9, 7, 5],
          [0, 0, 6, 0, 5, 0, 4, 3, 0],
          [0, 0, 9, 7, 0, 0, 0, 0, 0],
          [0, 0, 0, 4, 1, 0, 5, 0, 0],
          [5, 0, 2, 0, 0, 3, 0, 0, 0],
          [0, 0, 0, 5, 0, 2, 0, 0, 0],
        ];
        expect(SudokuUtilities.isSolved(SudokuSolver.solve(sudoku)), isTrue);
      });

      test('Multiple solutions - 80', () {
        var sudoku = <List<int>>[
          [0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 9, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0],
        ];
        expect(SudokuUtilities.isSolved(SudokuSolver.solve(sudoku)), isTrue);
      });
    });

    group('SudokuSolver exception tests', () {
      test('Invalid Sudoku - Repetitive numbers', () {
        var sudoku = <List<int>>[
          [2, 1, 7, 4, 3, 5, 9, 2, 8],
          [5, 8, 9, 0, 6, 2, 4, 3, 0],
          [3, 4, 6, 0, 7, 9, 2, 5, 1],
          [1, 6, 2, 3, 0, 0, 5, 4, 0],
          [9, 0, 5, 2, 0, 4, 7, 8, 6],
          [4, 7, 8, 5, 9, 6, 1, 0, 0],
          [8, 0, 3, 0, 4, 1, 6, 7, 2],
          [0, 9, 4, 7, 2, 3, 8, 1, 5],
          [7, 2, 1, 0, 5, 0, 0, 0, 4],
        ];
        expect(() => SudokuSolver.solve(sudoku), throwsException);
      });

      test('Invalid Sudoku - Wrong numbers', () {
        var sudoku = <List<int>>[
          [2, 1, 7, 4, 3, 5, 9, 29, 8],
          [5, 8, 9, 0, 6, 2, 4, 3, 0],
          [3, 4, 6, 0, 7, 9, 2, 5, 1],
          [1, 6, 2, 3, 0, 0, 5, 4, 0],
          [9, 0, 5, 2, 0, 4, 7, 8, 6],
          [4, 7, 8, 5, 9, 6, 1, 0, 0],
          [8, 0, 3, 0, 4, 1, 6, 7, 2],
          [0, 9, 4, 7, 2, 3, 8, 1, 5],
          [7, 2, 1, 0, 5, 0, 0, 0, 4],
        ];
        expect(() => SudokuSolver.solve(sudoku), throwsException);
      });

      test('Invalid Sudoku - Wrong List dimensions (rows)', () {
        var sudoku = <List<int>>[
          [2, 1, 7, 4, 3, 5, 9, 6, 8],
          [5, 8, 9, 0, 6, 2, 4, 3, 0],
          [3, 4, 6, 0, 7, 9, 2, 5, 1],
          [1, 6, 2, 3, 0, 0, 5, 4, 0],
          [9, 0, 5, 2, 0, 4, 7, 8, 6],
          [4, 7, 8, 5, 9, 6, 1, 0, 0],
          [8, 0, 3, 0, 4, 1, 6, 7, 2],
          [0, 9, 4, 7, 2, 3, 8, 1, 5],
        ];
        expect(() => SudokuSolver.solve(sudoku), throwsException);
      });

      test('Invalid Sudoku - Wrong List dimensions (columns)', () {
        var sudoku = <List<int>>[
          [2, 1, 7, 4, 3, 5, 9, 6, 8],
          [5, 8, 9, 0, 6, 2, 4, 3, 0],
          [3, 4, 6, 0, 7, 9, 2, 5, 1],
          [1, 6, 2, 3, 0, 0, 5, 4],
          [9, 0, 5, 2, 0, 4, 7, 8, 6],
          [4, 7, 8, 5, 9, 6, 1, 0, 0],
          [8, 0, 3, 0, 4, 1, 6, 7, 2],
          [0, 9, 4, 7, 2, 3, 8, 1, 5],
          [7, 2, 1, 0, 5, 0, 0, 0, 4],
        ];
        expect(() => SudokuSolver.solve(sudoku), throwsException);
      });
    });
  });
}
