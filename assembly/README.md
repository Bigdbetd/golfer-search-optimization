# Assembly evidence

The critical functions were compiled in Compiler Explorer with x86-64 GCC 16.2 at -O2 -x c. The screenshots show actual output. Local baseline.s and optimized.s use GCC 14.2.0 with -O2 -S -masm=intel. Both loops retain scalar square roots; list traversal loads a next pointer, while array traversal advances by a fixed 32-byte stride.
