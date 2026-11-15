/* Baseline: one malloc per golfer and a dependent next-pointer traversal. */
#define VERSION "baseline"
#define RECORD_BYTES sizeof(Node)
#define PROFILE_ALLOCS(n) (n)
#include "common.h"
static void store_free(Store *s) {
    Node *p = s->head;
    while (p) { Node *next = p->next; free(p); p = next; }
    *s = (Store){0};
}
static int store_create(Store *s, size_t n, const Profile *source) {
    *s = (Store){0}; uint32_t seed = 123456789U; Node **tail = &s->head;
    for (size_t i = 0; i < n; ++i) {
        Node *node = malloc(sizeof(*node));
        if (!node) { store_free(s); return 0; }
        node->p = source ? source[i] : make_profile(&seed,i); node->next = NULL;
        *tail = node; tail = &node->next;
    }
    s->n = n; return 1;
}
size_t search(const Store *s, const Query *q) {
    size_t matches = 0;
    for (const Node *node = s->head; node; node = node->next) {
        const Profile *p = &node->p;
        if (p->available && p->skill >= q->low && p->skill <= q->high) {
            double dx = p->x - q->x, dy = p->y - q->y;
            if (sqrt(dx * dx + dy * dy) <= q->radius) ++matches;
        }
    }
    return matches;
}
