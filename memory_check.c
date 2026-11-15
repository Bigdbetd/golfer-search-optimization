/* Test-only linker wrappers: track program malloc/free calls and inject failure. */
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
static size_t live, attempts, allocations, frees;
void *__real_malloc(size_t);
void __real_free(void *);
void *__wrap_malloc(size_t n) {
    ++attempts;
    const char *fail = getenv("FAIL_AT");
    if (fail && attempts == strtoull(fail,NULL,10)) return NULL;
    void *p = __real_malloc(n);
    if (p) { ++live; ++allocations; }
    return p;
}
void __wrap_free(void *p) {
    if (p) { if (!live) abort(); --live; ++frees; }
    __real_free(p);
}
__attribute__((destructor)) static void check_memory(void) {
    fprintf(stderr,"memory-check: allocations=%zu frees=%zu live=%zu\n",allocations,frees,live);
    if (live) abort();
}
