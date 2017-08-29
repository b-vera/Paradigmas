#include <stdio.h>
#include <stdlib.h>

typedef struct{
    char caracter;
    char * arreglo;
    char ** matriz;
} Estructura;

void example_1(){
    Estructura estructura;
    Estructura * ptr;
    //ptr = (Estructura *)malloc(sizof(Estructura));
    ptr = &estructura;
    ptr -> caracter = 'a';
    printf("%c\n",ptr-> caracter);


    ptr -> arreglo = (char*)malloc(sizeof(char)*10);
    int i;
    for (i = 0; i < 10; i++) {
        ptr -> arreglo[i]='b';
    }
    for (i = 0; i < 10; i++) {
        printf("%c ",ptr -> arreglo[i]);
    }


    ptr -> matriz = (char **)malloc(sizeof(char*)*10);
    for (i = 0; i < 10; i++) {
        ptr -> matriz[i]= (char*)malloc(sizeof(char)*10);
    }
    for (i = 0; i < 10; i++) {
        for (i = 0; i < 10; i++) {
            ptr->matriz[i][j] = 'c';
        }
    }
    for (i = 0; i < 10; i++) {
        for (i = 0; i < 10; i++) {
            printf("%c ",ptr-> matriz[i][j]);
        }
    }

    //liberar memoria

    printf("se libera la memoria\n", );
    for (i = 0; i < 10; i++) {
        free(ptr->matriz[i]);
    }
    free(ptr->matriz);
    free(ptr->arreglo);
    //para liverar puntero
    ptr = NULL;
    free(ptr);
}

void example_2(){
    Estructura * estructura;
    estructura = (Estructura*)malloc(sizeof(Estructura));
    estructura -> caracter = 'a';
    printf("%c\n",estructura->caracter);

    estructura -> arreglo = (char*)malloc(sizeof(char)*10);
    int i;
    for (i = 0; i < 10; i++) {
        estructura -> arreglo[i]='b';
    }
    for (i = 0; i < 10; i++) {
        printf("%c ",estructura -> arreglo[i]);
    }
}


int main(){
    example_1();
    return 0;
}
