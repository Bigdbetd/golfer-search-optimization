# Golfer Search Optimization

Drew Newman — Final Project MVP

Find available nearby golfers within an inclusive skill range. The baseline stores each profile in a separately allocated linked-list node. The optimized implementation uses one contiguous array of structs. Both retain identical filters and `sqrt` calculations to isolate the data-layout change. Coordinates are local Cartesian kilometers, not geographic latitude/longitude. Both searches remain O(NQ).

## Build and run

Requires a POSIX C environment (Linux, macOS, or WSL), GCC, and Python 3 for the benchmark scripts. Keep `common.h` beside both source files. Link the math library with `-lm`.

```sh
git clone https://github.com/Bigdbetd/golfer-search-optimization.git
cd golfer-search-optimization
gcc -std=c11 -Wall -Wextra -Wpedantic -O2 baseline.c -o baseline -lm
gcc -std=c11 -Wall -Wextra -Wpedantic -O2 optimized.c -o optimized -lm
./baseline 100000 200 1
./optimized 100000 200 1
./baseline --self-test
./optimized --self-test
```

Arguments: `profiles queries repeats [--counts]`. Defaults: 100000 profiles, 200 queries, one repeat. `--counts` appends each query's match count, outside the timed search. Zero profiles are allowed; queries and repeats must be positive. Invalid numeric input and allocation failures return nonzero status.

## Reproduce benchmarks and verification

```sh
python3 benchmark.py
python3 verify.py
```

`benchmark.py` builds both versions at the same `-O2`, verifies every one of 200 query counts at 10000, 100000, and 1000000 profiles, calibrates identical repeat counts to at least 0.5 seconds per version, runs two warm-up batches and ten measured batches, and alternates execution order. Each batch is a fresh process; this is not a persistent-service benchmark. The median and IQR describe batch-average milliseconds per query, not individual-query latency percentiles. Timing uses `clock_gettime(CLOCK_MONOTONIC)` and excludes query generation, profile setup, verification, printing, and cleanup. Setup is measured separately. Data seed: 123456789; query seed: 987654321. Results are observable through a printed checksum.

`verify.py` requires GCC's AddressSanitizer/UBSan support and GNU-compatible linker wrappers. It checks warning-free unoptimized builds, edge cases, invalid input, balanced malloc/free calls, injected allocation failures, and sanitizer runs. LeakSanitizer is disabled in that script because tracing blocks it in the execution environment used here. See `results/verification.txt` for actual checks and limitations.

## Expected output

Each program prints one JSON object with version, profiles, queries, repeats, setup_seconds, search_seconds, checksum, profile_bytes, and profile_allocations. `profile_bytes` is requested profile payload including struct padding; allocator metadata and query memory are excluded. `checksum` is the sum of all query counts across all repeats. Compare counts as well as checksums for correctness. Times vary by machine.

## Measured results

Median milliseconds per query from ten batches on GCC 14.2.0, `-O2`, shared Linux environment:

| Profiles | Baseline ms/query | Optimized ms/query | Speedup |
|---:|---:|---:|---:|
| 10,000 | 0.095590 | 0.078453 | 1.218x |
| 100,000 | 1.064617 | 0.866226 | 1.229x |
| 1,000,000 | 13.639697 | 9.742827 | 1.400x |

The proposal's 2x goal at one million profiles was not reached by this single change. No cache-miss reduction is claimed as measured: hardware counters were not collected. Shared scheduling, allocator placement, filters, and retained square roots can affect results. See raw samples, setup medians, IQRs, and environment metadata in `results/`.

## Assembly analysis

`assembly/compiler_explorer.c` contains both critical functions for pasting into Compiler Explorer. Screenshots show x86-64 GCC 16.2 at `-O2 -x c` (the editor tab is labeled C++, but `-x c` selects C). Local assembly was generated separately with GCC 14.2.0:

```sh
gcc -O2 -S -masm=intel baseline.c -o assembly/baseline.s
gcc -O2 -S -masm=intel optimized.c -o assembly/optimized.s
```

The list advances with a dependent pointer load (`mov rax, QWORD PTR [rax+32]`); the array advances with a fixed stride (`add rdx, 32`). Both retain scalar `sqrtsd`; no SIMD speedup is claimed. Allocation savings affect setup, while smaller records and traversal changes can affect searches. The array is 32 bytes/profile versus 40 bytes/node on this build, excluding allocator overhead.

## Files and next steps

- `baseline.c`, `optimized.c`, `common.h`: implementations and shared deterministic harness.
- `benchmark.py`: reproducible measurements; `verify.py` and `memory_check.c`: verification only.
- `results/`: raw measured trials, summary CSV/JSON, environment, verification log.
- `assembly/`: compiler output, standalone critical functions, and Compiler Explorer screenshots.
- `Final_Project_MVP_Drew_Newman.docx`: five-section analysis.

Next: test squared-distance comparisons with careful floating-point boundary tests, structure of arrays, and query batching separately; then compare combined changes and compiler levels fairly. This MVP implements only the contiguous-array strategy.
