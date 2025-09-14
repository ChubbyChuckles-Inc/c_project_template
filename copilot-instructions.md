# GitHub Copilot Instructions for C11 Multiplatform Template

## Code Standards

- C11 Only: Strictly adhere to C11 standard. No C++ features, no GNU extensions.
- Self-Documenting: Write crystal-clear code with concise comments only where ambiguity exists.
- Maintainable: Modular functions <100 lines, consistent snake_case naming, checked error returns.
- Optimized: Use inline/static for performance-critical code, avoid unnecessary allocations.
- Portable: Use ONLY MergeSource abstractions for OS calls, minimize #ifdef usage.

## File Organization and Refactoring Rules

- Single Responsibility: Each file should have ONE clear purpose and responsibility.
- Function Limits: Functions MUST be <100 lines. Split larger functions into smaller, focused ones.
- File Size Limits: Source files should be <500 lines. Split large files into logical modules.
- Header Organization: Separate interface (.h) from implementation (.c) always.
- Automatic Refactoring: When adding functionality that would exceed size limits, AUTOMATICALLY:
  1. Create new files with descriptive names
  2. Move related functions together
  3. Update include dependencies
  4. Maintain clear module boundaries

## Test Requirements (CRITICAL)

- One Test Per File: Each test file tests EXACTLY ONE function or feature.
- Deterministic Only: NO flaky tests. NO time-dependent tests. NO random behavior without seeds.
- Reproducible: Tests must produce identical results across runs and platforms.
- Isolated: Tests must not depend on external state or other tests.
- Named Clearly: test*[module]*[function]\_[scenario].c format required.

## MergeSource Library Usage

- Threading: Use imagine.h functions (imagine*mutex*_, imagine*thread*_)
- File I/O: Use forge.h functions (f*file*_, f*path*_)
- Graphics: Use betray.h for OpenGL/ES abstraction
- Networking: Use verse.h for network operations
- UI: Use seduce.h for user interface elements
- Memory: Use forge.h memory debugging (f_malloc, f_free, f_realloc)

## Prohibited Practices

- External dependencies (no libc extensions, no third-party libraries)
- Platform-specific code outside MergeSource abstractions
- Memory leaks (always pair allocations with deallocations)
- Magic numbers (use named constants)
- Global variables (prefer passing context structures)
- Files >500 lines (split immediately)
- Functions >100 lines (refactor immediately)
- Non-deterministic tests (reject and rewrite)

## Mandatory Refactoring Triggers

When any of these conditions are met, you MUST refactor immediately:

1. File exceeds 500 lines → Split into logical modules
2. Function exceeds 100 lines → Break into smaller functions
3. Cyclomatic complexity >10 → Simplify control flow
4. Code duplication detected → Extract common functions
5. More than 5 parameters → Use struct parameters
6. Deep nesting >4 levels → Extract functions or use early returns

## Quality Standards

- Cyclomatic complexity per function: ≤10
- Code coverage: ≥90% for all modules
- Zero memory leaks in all tests
- Zero static analysis warnings
- Consistent formatting via clang-format
- All public functions documented with Doxygen comments
