import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';
import 'package:test/test.dart';

void main() {
  group('SudokuGenerator Tests', () {
    group('SudokuGenerator unsolved tests', () {
      test('Default - 27', () {
        var generator = SudokuGenerator();
        expect(
            SudokuUtilities.isValidConfiguration(generator.newSudoku), isTrue);
      });

      test('Beginner - 18', () {
        var generator = SudokuGenerator(18);
        expect(
            SudokuUtilities.isValidConfiguration(generator.newSudoku), isTrue);
      });

      test('Easy - 27', () {
        var generator =
            SudokuGenerator(27); // ignore: avoid_redundant_argument_values
        expect(
            SudokuUtilities.isValidConfiguration(generator.newSudoku), isTrue);
      });

      test('Medium - 36', () {
        var generator = SudokuGenerator(36);
        expect(
            SudokuUtilities.isValidConfiguration(generator.newSudoku), isTrue);
      });

      test('Hard - 54', () {
        var generator = SudokuGenerator(54);
        expect(
            SudokuUtilities.isValidConfiguration(generator.newSudoku), isTrue);
      });
    });

    group('SudokuGenerator solved tests', () {
      test('Default', () {
        var generator = SudokuGenerator();
        expect(SudokuUtilities.isSolved(generator.newSudokuSolved), isTrue);
      });

      test('Beginner - 18', () {
        var generator = SudokuGenerator(18);
        expect(SudokuUtilities.isValidConfiguration(generator.newSudokuSolved),
            isTrue);
      });

      test('Easy - 27', () {
        var generator =
            SudokuGenerator(27); // ignore: avoid_redundant_argument_values
        expect(SudokuUtilities.isValidConfiguration(generator.newSudokuSolved),
            isTrue);
      });

      test('Medium - 36', () {
        var generator = SudokuGenerator(36);
        expect(SudokuUtilities.isValidConfiguration(generator.newSudokuSolved),
            isTrue);
      });

      test('Hard - 54', () {
        var generator = SudokuGenerator(54);
        expect(SudokuUtilities.isValidConfiguration(generator.newSudokuSolved),
            isTrue);
      });
    });

    group('SudokuGenerator exception tests', () {
      test('<1 emptySquares', () {
        expect(() => SudokuGenerator(0),
            throwsA(const TypeMatcher<InvalidEmptySquaresException>()));
      });

      test('>81 emptySquares', () {
        expect(() => SudokuGenerator(82),
            throwsA(const TypeMatcher<InvalidEmptySquaresException>()));
      });
    });
  });
}
