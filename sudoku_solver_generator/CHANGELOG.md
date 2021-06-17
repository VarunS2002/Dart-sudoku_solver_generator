## 2.1.0+1 - [17-06-2021]

- Updated Documentation
    - Fixed usage example in `README.md`

## 2.1.0 - [17-06-2021]

- **BREAKING CHANGE**
    - Bool parameter `animated` has been removed from `SudokuUtilities.printSudoku()`
    - This is because this breaks support for exporting to web (dart2js)

- Added back support for dart2js

## 2.0.0 - [14-06-2021]

- **BREAKING CHANGE**
    - If you manually specified `emptySquares` for `SudokuGenerator()` then it will break as it is a named parameter now
    - If the manually specified `emptySquares` is more than 54 then it will break as it cannot generate a unique
      solution and will throw a `UnlikelyUniqueSolutionException`
    - Fix: `SudokuGenerator(emptySquares: 54)` instead of `SudokuGenerator(54)`
    - Fix: `SudokuGenerator(emptySquares: 60, uniqueSolution: false)` if `emptySquares` is more than 54

- Added the bool parameter `uniqueSolution` to `SudokuGenerator()` to specify if a puzzle should have a unique solution
    - Defaults to `true`
    - `UnlikelyUniqueSolutionException` is thrown if `emptySquares` is `> 54`
    - This is because a unique solution is unlikely if there are less than `27` clues
    - Fixes the known issue

- Added function `SudokuUtilities.hasUniqueSolution()` to check if a puzzle has a unique solution

- Improved function `SudokuUtilities.printSudoku()`
    - Improved the aesthetics of the output by adding spaces and new lines and removing commas and brackets
    - Added a bool parameter `animated` to animate it by printing the numbers one by one

- Improved documentation

## 1.1.0 - [08-06-2021]

- Improved checking if the Sudoku configuration is valid
    - `SudokuUtilities.isValidConfiguration()` now checks for invalid values in the puzzle
    - `{1, 2, 3, 4, 5, 6, 7, 8, 9, 0, null}` are considered valid

- Fixed RangeError in `SudokuUtilities.to2D()` if Sudoku dimensions aren't valid

## 1.0.0+2 - [06-06-2021]

- Updated Documentation
    - Description in `pubspec.yaml`

## 1.0.0+1 - [06-06-2021]

- Updated Documentation
    - Description in `README.md`
    - Usage in `README.md`

## 1.0.0 - [06-06-2021]

- First Release
