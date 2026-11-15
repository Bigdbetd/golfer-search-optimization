/* MVP optimization: contiguous array only; filters and sqrt are unchanged. */
#define VERSION "optimized"
#define RECORD_BYTES sizeof(Profile)
#define PROFILE_ALLOCS(n) ((void)(n), (size_t)1)
#include "common.h"
static void store_free(Store *s) { free(s->items); *s = (Store){0}; }
static int store_create(Store *s, size_t n, const Profile *source) {
    *s = (Store){0};
    if (n > SIZE_MAX / sizeof(Profile)) return 0;
    if (n == 0) return 1;
    s->items = malloc(n * sizeof(*s->items));
    if (!s->items) return 0;
    uint32_t seed = 123456789U;
    for (size_t i = 0; i < n; ++i) s->items[i] = source ? source[i] : make_profile(&seed,i);
    s->n = n; return 1;
}
size_t search(const Store *s, const Query *q) {
    size_t matches = 0;
    for (size_t i = 0; i < s->n; ++i) {
        const Profile *p = &s->items[i];
        if (p->available && p->skill >= q->low && p->skill <= q->high) {
            double dx = p->x - q->x, dy = p->y - q->y;
            if (sqrt(dx * dx + dy * dy) <= q->radius) ++matches;
        }
    }
    return matches;
}
