#include <stdio.h>
#include <stdlib.h>

typedef struct{
    char * arreglo2;
    char ** matriz2;
}Estructura2;

typedef struct{
    char caracter;
    char * arreglo;
    Estructura2 * estructura2;
} Estructura;


/* estructura para ejemplos
typedef struct{
    char caracter;
    char * arreglo;
    char ** matriz;
} Estructura;
*/

void example_1(){
    Estructura estructura;
    Estructura * ptr;
    //ptr = (Estructura *)malloc(sizof(Estructura));
    ptr = &estructura;
    ptr -> caracter = 'a';
    printf("%c\n",ptr -> caracter);


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
    //para liberar puntero
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


    estructura -> matriz = (char **)malloc(sizeof(char*)*10);
    for (i = 0; i < 10; i++) {
        estructura -> matriz[i]= (char*)malloc(sizeof(char)*10);
    }
    for (i = 0; i < 10; i++) {
        for (i = 0; i < 10; i++) {
            estructura->matriz[i][j] = 'c';
        }
    }
    for (i = 0; i < 10; i++) {
        for (i = 0; i < 10; i++) {
            printf("%c ",estructura-> matriz[i][j]);
        }
    }

    printf("se libera la memoria\n", );
    for (i = 0; i < 10; i++) {
        free(estructura->matriz[i]);
    }
    free(estructura->matriz);
    free(estructura->arreglo);
    //para liverar puntero
    estructura = NULL;
    free(estructura);
}

void tarea(){
    Estructura* estructura;
    estructura=(Estructura*)malloc(sizeof(Estructura));
    estructura->estructura2 = (Estructura2*)malloc(sizeof(Estructura2));
    estructura->estructura2 -> arreglo2 = (char *)malloc(sizeof(char)*10);
    int i,j;
    for (i = 0; i < 10; i++) {
        estructura -> estructura2 -> arreglo2[i]='b';
    }
    for (i = 0; i < 10; i++) {
        printf("%c ",estructura -> estructura2 -> arreglo2[i]);
    }


    estructura->estructura2 -> matriz2 = (char **)malloc(sizeof(char*)*10);
    for (i = 0; i < 10; i++) {
        estructura -> estructura2 -> matriz2[i] = (char*)malloc(sizeof(char)*10);
    }

    for (i = 0; i < 10; i++) {
        for (j = 0; j < 10; j++) {
            estructura->estructura2->matriz2[i][j] = 'c';
        }
    }
    for (i = 0; i < 10; i++) {
        for (j = 0; j < 10; j++) {
            printf("%c ",estructura->estructura2->matriz2[i][j]);
        }
        printf("\n");
    }

    printf("liberando memoria\n");
    free(estructura->estructura2->arreglo2);
    for (i = 0; i < 10; i++) {
        free(estructura->estructura2->matriz2[i]);
    }
    free(estructura->estructura2->matriz2);
    free(estructura->estructura2);
    free(estructura);


    for (i = 0; i < 10; i++) {
        for (j = 0; j < 10; j++) {
            printf("%c ",estructura->estructura2->matriz2[i][j]);
        }
        printf("\n");
    }
}


int main(){
    tarea();
    return 0;
}
