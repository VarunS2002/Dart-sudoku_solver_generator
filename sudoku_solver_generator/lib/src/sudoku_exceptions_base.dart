/// Thrown when the configuration of the Sudoku is not valid.
///
/// Configuration of the Sudoku follows the rules of Sudoku.
///
/// Conditions:
/// * [List] of 9 [List]s of 9 [int]s
/// * Every row must have the numbers 1-9 without repetition
/// * Every column must have the numbers 1-9 without repetition
/// * Every 3x3 box must have the number 1-9 without repetition
/// * Only positions of non-zero and non-null values are considered
/// * Solvability of the puzzle is not considered
///
/// [SudokuUtilities.isValidConfiguration()] can be used to check for validity
/// to prevent this Exception.
class InvalidSudokuConfigurationException implements Exception {
  /// Returns the error message
  String errorMessage() =>
      'The configuration for the Sudoku puzzle is invalid.';

  @override
  String toString() => 'InvalidSudokuConfigurationException';
}

/// Thrown when the value of the [emptySquares] parameter of [SudokuGenerator]
/// is invalid.
///
/// Valid values: Any integer from 1-81 (inclusive).
class InvalidEmptySquaresException implements Exception {
  /// Returns the error message
  String errorMessage() =>
      'The number of empty squares cannot be less than 1 or more than 81.';

  @override
  String toString() => 'InvalidEmptySquaresException';
}

/// Thrown when the value of the [emptySquares] parameter of [SudokuGenerator]
/// is `> 54` and [uniqueSolution] is set to `true`.
///
/// This is because a unique solution is unlikely if there are less than
/// `27` clues.
class UnlikelyUniqueSolutionException implements Exception {
  /// Returns the error message
  String errorMessage() => 'The number of empty squares cannot more than 54 if '
      'a unique solution is needed.';

  @override
  String toString() => 'UnlikelyUniqueSolutionException';
}
