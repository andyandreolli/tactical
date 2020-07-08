# Tactical

A repository of tactical utilities.

## Packages and usage:

- `tactical.io.size_ram_check(filename)`: checks if file is small enough to be loaded into memory without causing swapping
  - `filename` is a string
  - returns nothing; requires user input to proceed if file is too large