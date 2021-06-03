///
class InvalidSudokuConfigurationException implements Exception {
  String errorMessage() =>
      'The configuration for the Sudoku puzzle is invalid.';

  @override
  String toString() => 'InvalidSudokuConfigurationException';
}
