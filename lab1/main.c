#include <stdio.h>
#include <stdlib.h>
#include "listas.h"
#include "archivos.h"
#include "StopWords.h"

enum   code   {OK,   ERR_FILE_NOT_FOUND,   ERR_FILE_NOT_PERM};

/*typedef   struct   Index   {
}   Index;

typedef   struct   Result   {
}   Result;

typedef   struct   Ranking   {
}   Ranking;
*/

int main () {
    Lista * listaPalabras = createList();
    Lista * listaStopWords = createList();
    //printf("post init: %d\n", listaPalabras->tamano);
    lecturaArchivo("doc1.txt",listaPalabras);
    lecturaArchivo("StopWords.txt",listaStopWords);
    //printf("post leer: %d\n", listaPalabras->tamano);
    imprimirLista(listaPalabras);

    return 0;
}
