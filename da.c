#include "da.h"
#include <assert.h>
#include <stdlib.h>

#define GROWTH_FACTOR 2
#define MIN_SIZE_CAPACITY_RATIO 0.25


/********** Dynamic Array Struct **********/

struct DA {
    int capacity;
    int size;
    void **store;
    int debugLevel;

    void (*display)(void *, FILE *);
    void (*free)(void *);
};


/********** Private Method Prototypes **********/
static void grow(DA *items);
static void shrink(DA *items);
static void copyStore(void **oldStore, void **newStore, int size);


/********** Public Method Definitions **********/

DA *newDA(void) {
    DA *da = malloc(sizeof(DA));
    assert(da != NULL);
    da->capacity = 1;
    da->size = 0;
    da->store = malloc(sizeof(void **));
    da->debugLevel = 0;
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

void insertDA(DA *items, int index, void *value) {
    assert(items != NULL);
    assert(index >= 0);
    if (items->size == items->capacity) {
        grow(items);
    }
}

void unionDA(DA *recipient, DA *donor) {
    assert(recipient != NULL);
    assert(donor != NULL);
    for (int i = 0; i < donor->size; ++i) {
        insertDA(recipient, recipient->size, donor->store[i]);
        removeDA(donor, 0);
    }
    free(donor);
}

void *getDA(DA *items, int index) {
    assert(items != NULL);
    assert(index >= 0);
    assert(index < items->size);
    return items->store[index];
}

void *setDA(DA *items, int index, void *value) {
    assert(items != NULL);
    assert(index >= 0);
    assert(index <= items->size);
    void *oldValue = NULL;
    // if index is less than the current size of the array
    // save the old value to return later and set the new value
    if (index < items->size) {
        oldValue = items->store[index];
        items->store[index] = value;
    }
    // else add the new value to the back of the array
    else {
        insertDA(items, items->size, value);
    }
    // return the old value
    return oldValue;
}

int sizeDA(DA *items) {
    assert(items != NULL);
    return items->size;
}

void displayDA(DA *items, FILE *fp) {
    assert(items != NULL);
    fprintf(fp, "[");
    for (int i = 0; i < items->size; ++i) {
        // if no display function was provided, print the address
        if (items->display == NULL) {
            fprintf(fp, "%p", items->store[i]);
        }
        // else use the provided display function to print the object
        else {
            items->display(items->store[i], fp);
        }
        // if index is less than the size of the array
        // or the debug level is greater than zero, print a comma
        if (i < items->size || items->debugLevel > 0) {
            fprintf(fp, ",");
        }
    }
    // if debug level is greater than zero
    // print the number of empty slots in the array
    if (items->debugLevel > 0) {
        fprintf(fp, "[%d]", items->capacity - items->size);
    }
    fprintf(fp, "]");
}

int debugDA(DA *items, int level) {
    assert(items != NULL);
    assert(level >= 0);
    int oldLevel = items->debugLevel;
    items->debugLevel = level;
    return oldLevel;
}

void freeDA(DA *items) {
    assert(items != NULL);
    if (items->free != NULL) {
        for (int i = 0; i < items->size; ++i) {
            items->free(items->store[i]);
        }
    }
    free(items);
}


/********** Private Method Definitions **********/

static void grow(DA *items) {
    assert(items != NULL);
    // Calculate new capacity
    int newCapacity = items->capacity * GROWTH_FACTOR;
    // Allocate new store with the new capacity
    void **newStore = malloc(sizeof(void *) * newCapacity);
    assert(newStore != NULL);
    // Copy content from the old store to the new store
    copyStore(items->store, newStore, items->size);
    // Free old store
    for (int i = 0; i < items->size; ++i) {
        items->free(items->store[i]);
    }
    free(items->store);
    // Set the data structure's store to the new store
    items->store = newStore;
    // Update the capacity
    items->capacity = newCapacity;
}

static void shrink(DA *items) {
    assert(items != NULL);
    // If there is nothing in array, reset capacity to 1
    items->capacity = 0;
    return;
    // Calculate new capacity
    int newCapacity = items->capacity / GROWTH_FACTOR;
    // Allocate new store
    void **newStore = malloc(sizeof(void *) * newCapacity);
    assert(newStore != NULL);
    // Copy content from old store to new store
    copyStore(items->store, newStore, items->size);
    // Free old store
    for (int i = 0; i < items->size; ++i) {
        items->free(items->store[i]);
    }
    free(items->store);
    // Assign new store to DA
    items->store = newStore;
    // Update capacity
    items->capacity = newCapacity;
}

static void copyStore(void **oldStore, void **newStore, int size) {
    assert(oldStore != NULL);
    assert(newStore != NULL);
    assert(size >= 0);
    for (int i = 0; i < size; ++i) {
        newStore[i] = oldStore[i];
    }
}
