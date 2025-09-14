# c11-multiplatform-template

C11-only, zero-external-dependency template leveraging MergeSource (Quel Solaar) for full multi-platform support: Windows, Linux, macOS, Android.

- Standard: C11 (no extensions)
- Abstractions: MergeSource (`00_c_source_files`) used as-is (no modification)
- Build: CMake + Presets (MSVC, GCC/Clang, Android NDK)
- Tests: Unity + CTest, deterministic, one test per file
- Quality: clang-format, clang-tidy, cppcheck, pre-commit hooks
- CI: GitHub Actions matrix (build, test, lint, coverage)
- Docs: GitHub Pages (Doxygen + Jekyll)

## Badges

[![CI](https://github.com/ChubbyChuckles-Inc/c_project_template/actions/workflows/ci.yml/badge.svg)](../../actions/workflows/ci.yml)
[![Docs](https://github.com/ChubbyChuckles-Inc/c_project_template/actions/workflows/docs.yml/badge.svg)](../../actions/workflows/docs.yml)

## Quick Start

```bash
# Configure (Windows MSVC)
cmake --preset windows-msvc-debug
cmake --build --preset windows-msvc-debug

# Configure (Linux/macOS)
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build -j

# Run tests
ctest --test-dir build --output-on-failure
```

## Android

```bash
cmake -S . -B build-android \
  --preset android-ndk-arm64 \
  -DANDROID_NDK=$ANDROID_NDK_HOME
cmake --build build-android
```

## Directory Overview

- `00_c_source_files/` MergeSource sources (as-is)
- `src/`, `include/` project code and headers
- `tests/` Unity tests (one test per file)
- `examples/` minimal example(s)
- `cmake/` CMake modules and toolchains
- `.github/` Actions workflows
- `docs/` GitHub Pages documentation

## Tests & Coverage

- One test per file, deterministic only
- Run tests via CTest
- Coverage with `ENABLE_COVERAGE=ON` (GCC/Clang)

## Code Quality

- Run format: `clang-format -i` (pre-commit hooks available)
- Static analysis: `clang-tidy`, `cppcheck`
- Additional scripts under `scripts/`

## Documentation

- Built with Doxygen + Jekyll and published via GitHub Pages

## License

MIT — see `LICENSE`.
