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
    Lista * listaPalabras = createList();
    printf("post init: %d\n", listaPalabras->tamano);
    //leerArchivo("doc1.txt",listaPalabras);
    lecturaArchivo("doc1.txt",listaPalabras);

    printf("post leer: %d\n", listaPalabras->tamano);
    imprimirLista(listaPalabras);


    return 0;
}
