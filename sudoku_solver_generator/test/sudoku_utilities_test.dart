import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';
import 'package:test/test.dart';

void main() {
  group('SudokuUtilities Tests', () {
    group('2D to 1D', () {
      test('Valid', () {
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
        var sudoku1D = SudokuUtilities.to1D(sudoku);
        expect(
            sudoku1D.runtimeType.toString() == 'List<int>' &&
                sudoku1D.length == 81,
            isTrue);
      });

      test('Invalid Repetitive numbers', () {
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
        expect(() => SudokuUtilities.to1D(sudoku),
            throwsA(const TypeMatcher<InvalidSudokuConfigurationException>()));
      });

      test('Invalid Wrong numbers', () {
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
        expect(() => SudokuUtilities.to1D(sudoku),
            throwsA(const TypeMatcher<InvalidSudokuConfigurationException>()));
      });

      test('Invalid Wrong List dimensions (rows)', () {
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
        expect(() => SudokuUtilities.to1D(sudoku),
            throwsA(const TypeMatcher<InvalidSudokuConfigurationException>()));
      });

      test('Invalid Wrong List dimensions (columns)', () {
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
        expect(() => SudokuUtilities.to1D(sudoku),
            throwsA(const TypeMatcher<InvalidSudokuConfigurationException>()));
      });
    });

    group('1D to 2D', () {
      test('Valid', () {
        var sudoku = [1, 3, 2, 4, 6, 5, 7, 9, 8, 4, 8, 5, 1, 7, 9, 2, 3, 6, 6,
          7, 9, 2, 3, 8, 1, 4, 5, 2, 6, 7, 9, 4, 3, 8, 5, 1, 3, 9, 1, 8, 5, 2,
          6, 7, 4, 5, 4, 8, 7, 1, 6, 9, 2, 3, 8, 2, 3, 5, 9, 1, 4, 6, 7, 9, 5,
          4, 6, 8, 7, 3, 1, 2, 7, 1, 6, 3, 2, 4, 5, 8, 9];
        var sudoku2D = SudokuUtilities.to2D(sudoku);
        expect(
            sudoku2D.runtimeType.toString() == 'List<List<int>>' &&
                sudoku2D.length == 9 &&
                sudoku2D.every((row) => row.length == 9),
            isTrue);
      });

      test('Invalid Repetitive numbers', () {
        var sudoku = [3, 3, 2, 4, 6, 5, 7, 9, 8, 4, 8, 5, 1, 7, 9, 2, 3, 6, 6,
          7, 9, 2, 3, 8, 1, 4, 5, 2, 6, 7, 9, 4, 3, 8, 5, 1, 3, 9, 1, 8, 5, 2,
          6, 7, 4, 5, 4, 8, 7, 1, 6, 9, 2, 3, 8, 2, 3, 5, 9, 1, 4, 6, 7, 9, 5,
          4, 6, 8, 7, 3, 1, 2, 7, 1, 6, 3, 2, 4, 5, 8, 9];
        expect(() => SudokuUtilities.to2D(sudoku),
            throwsA(const TypeMatcher<InvalidSudokuConfigurationException>()));
      });

      test('Invalid Wrong numbers', () {
        var sudoku = [39, 3, 2, 4, 6, 5, 7, 9, 8, 4, 8, 5, 1, 7, 9, 2, 3, 6, 6,
          7, 9, 2, 3, 8, 1, 4, 5, 2, 6, 7, 9, 4, 3, 8, 5, 1, 3, 9, 1, 8, 5, 2,
          6, 7, 4, 5, 4, 8, 7, 1, 6, 9, 2, 3, 8, 2, 3, 5, 9, 1, 4, 6, 7, 9, 5,
          4, 6, 8, 7, 3, 1, 2, 7, 1, 6, 3, 2, 4, 5, 8, 9];
        expect(() => SudokuUtilities.to2D(sudoku),
            throwsA(const TypeMatcher<InvalidSudokuConfigurationException>()));
      });

      test('Invalid Wrong List dimensions', () {
        var sudoku = [1, 3, 2, 4, 6, 5, 7, 9, 8, 4, 8, 5, 1, 7, 9, 2, 3, 6, 6,
          7, 9, 2, 3, 8, 1, 4, 5, 2, 6, 7, 9, 4, 3, 8, 5, 1, 3, 9, 1, 8, 5, 2,
          6, 7, 4, 5, 4, 8, 7, 1, 6, 9, 2, 3, 8, 2, 3, 5, 9, 1, 4, 6, 7, 9, 5,
          4, 6, 8, 7, 3, 1, 2, 7, 1, 6, 3, 2, 4, 5, 8];
        expect(() => SudokuUtilities.to2D(sudoku),
            throwsA(const TypeMatcher<InvalidSudokuConfigurationException>()));
      });
    });
  });
}
