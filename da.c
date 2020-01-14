#include "da.h"
#include <assert.h>
#include <stdlib.h>

#define FACTOR 2
#define MIN_SIZE_CAPACITY_RATIO 0.25

#define insertDAfront(items, value)     insertDA(items, 0, value)
#define removeDAfront(items)            removeDA(items, 0)
#define insertDAback(items, value)      insertDA(items, sizeDA(items) - 1, value)
#define removeDAback(items)             removeDA(items, sizeDA(items) - 1)

struct DA {
    int capacity;
    int size;
    void **store;

    void (*display)(void *, FILE *);
    void (*free)(void *);
};

DA *newDA(void) {
    DA *da = malloc(sizeof(DA));
    assert(da != NULL);
    da->capacity = 1;
    da->size = 0;
    da->store = malloc(sizeof(void**));
    return da;
}

void setDAdisplay(DA *items, void (*display)(void *, FILE *)) {
    assert(items != NULL);
    items->display = display;
}

void setDAfree(DA *items, void (*free)(void *)) {
    assert(items != NULL);
    items->free = free;
}

int sizeDA(DA *items) {
    assert(items != NULL);
    return items->size;
}
