#include <stddef.h>
#include <stdint.h>
#include <math.h>
typedef struct { double x, y; uint32_t id; int skill, available; } Profile;
typedef struct Node { Profile p; struct Node *next; } Node;
typedef struct { Node *head; Profile *items; size_t n; } Store;
typedef struct { double x, y, radius; int low, high; } Query;
size_t baseline_search(const Store *s, const Query *q) {
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

size_t optimized_search(const Store *s, const Query *q) {
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

