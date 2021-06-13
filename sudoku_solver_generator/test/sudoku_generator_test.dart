import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';
import 'package:test/test.dart';

void main() {
  group('SudokuGenerator Tests', () {
    group('SudokuGenerator unsolved tests', () {
      test('Beginner - 18', () {
        var generator = SudokuGenerator(emptySquares: 18);
        expect(
            SudokuUtilities.isValidConfiguration(generator.newSudoku), isTrue);
      });

      test('Easy - 27 (default)', () {
        var generator = SudokuGenerator();
        expect(
            SudokuUtilities.isValidConfiguration(generator.newSudoku), isTrue);
      });

      test('Medium - 36', () {
        var generator = SudokuGenerator(emptySquares: 36);
        expect(
            SudokuUtilities.isValidConfiguration(generator.newSudoku), isTrue);
      });

      test('Hard - 54', () {
        var generator = SudokuGenerator(emptySquares: 54);
        expect(
            SudokuUtilities.isValidConfiguration(generator.newSudoku), isTrue);
      });

      test('Unrealistic - 80', () {
        var generator =
            SudokuGenerator(emptySquares: 80, uniqueSolution: false);
        expect(
            SudokuUtilities.isValidConfiguration(generator.newSudoku), isTrue);
      });
    });

    group('SudokuGenerator unique solution tests', () {
      test('Beginner - 18', () {
        var generator = SudokuGenerator(emptySquares: 18);
        expect(SudokuUtilities.hasUniqueSolution(generator.newSudoku), isTrue);
      });

      test('Easy - 27 (default)', () {
        var generator = SudokuGenerator();
        expect(SudokuUtilities.hasUniqueSolution(generator.newSudoku), isTrue);
      });

      test('Medium - 36', () {
        var generator = SudokuGenerator(emptySquares: 36);
        expect(SudokuUtilities.hasUniqueSolution(generator.newSudoku), isTrue);
      });

      test('Hard - 54', () {
        var generator = SudokuGenerator(emptySquares: 54);
        expect(SudokuUtilities.hasUniqueSolution(generator.newSudoku), isTrue);
      });
    });

    group('SudokuGenerator solved tests', () {
      test('Beginner - 18', () {
        var generator = SudokuGenerator(emptySquares: 18);
        expect(SudokuUtilities.isValidConfiguration(generator.newSudokuSolved),
            isTrue);
      });

      test('Easy - 27 (default)', () {
        var generator = SudokuGenerator();
        expect(SudokuUtilities.isValidConfiguration(generator.newSudokuSolved),
            isTrue);
      });

      test('Medium - 36', () {
        var generator = SudokuGenerator(emptySquares: 36);
        expect(SudokuUtilities.isValidConfiguration(generator.newSudokuSolved),
            isTrue);
      });

      test('Hard - 54', () {
        var generator = SudokuGenerator(emptySquares: 54);
        expect(SudokuUtilities.isValidConfiguration(generator.newSudokuSolved),
            isTrue);
      });
    });

    group('SudokuGenerator exception tests', () {
      test('<1 emptySquares', () {
        expect(() => SudokuGenerator(emptySquares: 0),
            throwsA(const TypeMatcher<InvalidEmptySquaresException>()));
      });

      test('>81 emptySquares (no uniqueSolution)', () {
        expect(() => SudokuGenerator(emptySquares: 82, uniqueSolution: false),
            throwsA(const TypeMatcher<InvalidEmptySquaresException>()));
      });

      test('>54 emptySquares (uniqueSolution)', () {
        expect(() => SudokuGenerator(emptySquares: 55),
            throwsA(const TypeMatcher<UnlikelyUniqueSolutionException>()));
      });
    });
  });
}
