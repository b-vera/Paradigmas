#pragma once

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct Nodo{
    char* data;
    int key;
    struct Nodo * siguiente;
}Nodo;

typedef struct Lista{
    Nodo * head;
    Nodo * tail;
    int tamano;
}Lista;

// crear una lista
Lista * createList(){
    Lista * List = (Lista *)malloc(sizeof(Lista));
    List->head = NULL;
    List->tail = NULL;
    List->tamano = 0;
    return List;
}

// creado el nuevo nodo
void agregar(Lista * list,char* data, int key){

    Nodo * link = (Nodo *)malloc(sizeof(Nodo));
    link->data = (char *)malloc(strlen(data)*sizeof(char));

    if (list->tamano == 0 ) {
        // printf("hola1\n");
        list->head= link;
        list->tail = link;
        link->key = key;
        link->siguiente = NULL;
        strcpy(link->data,data);
        list->tamano++;

    }else {
        // printf("hola2\n");
        link->siguiente = NULL;
        list->tail->siguiente = link;
        link->key = key;
        list->tamano++;
        strcpy(link->data,data);
        list->tail = link;
    }
}

// imprimir el contenido de la lista
void imprimirLista(Lista * list){
    printf("entre a imprimir lista\n");
    Nodo *ptr = list->head;
    while(ptr->siguiente) {
        printf("%d.- %s\n",ptr->key,ptr->data);
        ptr = ptr->siguiente;
    }

}
