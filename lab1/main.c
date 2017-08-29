#include <stdio.h>
#include <stdlib.h>
#include "listas.h"
#include "archivos.h"

/*typedef   struct   Index   {
}   Index;

typedef   struct   Result   {
}   Result;

typedef   struct   Ranking   {
}   Ranking;

typedef   struct   StopWords   {
}   StopWords;
*/

int main () {
    //leerArchivo("StopWords.txt");
    Lista * lista1 = createList();
    printf("post init: %d\n", lista1->tamano);
    leerArchivo("doc1.txt",lista1);
    printf("post leer: %d\n", lista1->tamano);
    imprimirLista(lista1);

    //prueba
    /*for (int i = 0; i < 10; i++) {
        agregar(lista1,"hola",i);
    }*/

    return 0;
}
