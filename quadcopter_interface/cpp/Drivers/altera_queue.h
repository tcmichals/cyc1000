#ifndef _QUEUE_
#define _QUEUE_

typedef struct _QueueNode {
    void *data;
    struct _QueueNode *link;
} QueueNode;

typedef struct _Queue {
    int size;
    QueueNode *head;
    QueueNode *tail;
} Queue;

void queue_init(Queue *q);

void queue_push(Queue *q, void *element);

void *queue_front(Queue *q);

void queue_pop(Queue *q, int release);

void queue_clear(Queue *q, int release);

int queue_size(Queue *q);

#endif 
