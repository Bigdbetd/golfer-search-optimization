#ifndef COMMON_H
#define COMMON_H
#define _POSIX_C_SOURCE 200809L
#include <errno.h>
#include <inttypes.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

typedef struct { double x, y; uint32_t id; int skill, available; } Profile;
typedef struct Node { Profile p; struct Node *next; } Node;
typedef struct { Node *head; Profile *items; size_t n; } Store;
typedef struct { double x, y, radius; int low, high; } Query;
static uint32_t rng_next(uint32_t *s) { *s = *s * UINT32_C(1664525) + UINT32_C(1013904223); return *s; }
static Profile make_profile(uint32_t *s, size_t i) {
    Profile p;
    p.id = (uint32_t)i;
    p.x = (double)(rng_next(s) % 100001) / 100.0;
    p.y = (double)(rng_next(s) % 100001) / 100.0;
    p.skill = (int)(rng_next(s) % 36);
    p.available = (int)((rng_next(s) >> 16) & 1U);
    return p;
}
static double now_seconds(void) {
    struct timespec t;
    if (clock_gettime(CLOCK_MONOTONIC, &t) != 0) { perror("clock_gettime"); exit(EXIT_FAILURE); }
    return (double)t.tv_sec + (double)t.tv_nsec * 1e-9;
}
static int store_create(Store *s, size_t n, const Profile *source);
static void store_free(Store *s);
size_t search(const Store *s, const Query *q);
static int parse_size(const char *arg, size_t *out) {
    char *end; unsigned long long value;
    if (!arg[0] || arg[0] == '-') return 0;
    errno = 0; value = strtoull(arg, &end, 10);
    if (errno || *end || value > SIZE_MAX) return 0;
    *out = (size_t)value; return 1;
}
static int self_test(void) {
    const Profile p[] = {{0,0,0,10,1},{3,4,1,10,1},{3,4,2,10,0},{0,0,3,20,1},{6,8,4,10,1},{-3,-4,5,10,1}};
    const Query q[] = {{0,0,5,10,10},{0,0,0,10,10},{0,0,10,10,10},{0,0,5,20,20},{0,0,100,30,35}};
    const size_t expected[] = {3,1,4,1,0};
    Store s = {0};
    if (!store_create(&s, 6, p)) return 1;
    for (size_t i = 0; i < sizeof(q)/sizeof(q[0]); ++i) {
        if (search(&s, &q[i]) != expected[i]) { store_free(&s); fprintf(stderr,"edge test failed\n"); return 1; }
    }
    store_free(&s);
    if (!store_create(&s, 0, NULL)) return 1;
    size_t count = search(&s, &q[0]); store_free(&s);
    if (count != 0) return 1;
    puts("PASS: empty data, zero radius, inclusive radius and skill boundaries, unavailable and no-match cases");
    return 0;
}
int main(int argc, char **argv) {
    size_t n = 100000, nq = 200, repeats = 1;
    if (argc == 2 && strcmp(argv[1], "--self-test") == 0) return self_test();
    if (argc > 5 || (argc > 1 && !parse_size(argv[1], &n)) ||
        (argc > 2 && !parse_size(argv[2], &nq)) || (argc > 3 && !parse_size(argv[3], &repeats)) ||
        nq == 0 || repeats == 0 || n > UINT32_MAX || nq > SIZE_MAX / sizeof(Query) ||
        repeats > UINT64_MAX / nq || (n && (uint64_t)repeats * nq > UINT64_MAX / n) ||
        (argc == 5 && strcmp(argv[4], "--counts") != 0)) {
        fprintf(stderr,"Usage: %s [profiles [queries [repeats [--counts]]]] | --self-test\n",argv[0]); return 1;
    }
    Query *queries = malloc(nq * sizeof(*queries));
    if (!queries) { perror("queries"); return 1; }
    uint32_t seed = 987654321U;
    for (size_t i = 0; i < nq; ++i) {
        queries[i].x = (double)(rng_next(&seed) % 100001) / 100.;
        queries[i].y = (double)(rng_next(&seed) % 100001) / 100.;
        queries[i].radius = 25. + (double)(rng_next(&seed) % 125);
        queries[i].low = (int)(rng_next(&seed) % 25); queries[i].high = queries[i].low + 10;
    }
    Store s = {0}; double begin = now_seconds();
    if (!store_create(&s,n,NULL)) { free(queries); fprintf(stderr,"Profile allocation failed\n"); return 1; }
    double setup = now_seconds() - begin;
    uint64_t checksum = 0;
    begin = now_seconds();
    for (size_t r = 0; r < repeats; ++r)
        for (size_t j = 0; j < nq; ++j) checksum += search(&s, &queries[j]);
    double elapsed = now_seconds() - begin;
    printf("{\"version\":\"%s\",\"profiles\":%zu,\"queries\":%zu,\"repeats\":%zu,\"setup_seconds\":%.9f,\"search_seconds\":%.9f,\"checksum\":%" PRIu64 ",\"profile_bytes\":%zu,\"profile_allocations\":%zu", VERSION,n,nq,repeats,setup,elapsed,checksum,n * RECORD_BYTES,n ? PROFILE_ALLOCS(n) : 0);
    if (argc == 5) {
        printf(",\"counts\":[");
        for (size_t j = 0; j < nq; ++j) printf("%s%zu",j ? "," : "",search(&s,&queries[j]));
        printf("]");
    }
    puts("}"); store_free(&s); free(queries); return 0;
}
#endif
