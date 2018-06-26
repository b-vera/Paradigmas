#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <stdbool.h>
#include "listas.h"

void leerArchivo(char * nombreArchivo, Lista * list){
    FILE *fp;
    char *line = NULL;

    size_t len = 0;
    ssize_t read;

    fp=fopen(nombreArchivo, "r");
    if (fp == NULL){
        exit(0);
    }

    int id = 1;
    while ((read = getline(&line, &len, fp)) != -1) {
        //printf("%zu:\n",read );
        printf("%s", line);
        // printf("agregar(%s)\n", line);
        agregar(list,line,id++);
    }
    fclose(fp);
    if (line){
        free(line);
    }
    return;
}

char * LimpiarPalabra(char * palabra){
    int i,j=0;
    int largo = strlen(palabra);
    char * nuevaPalabra =(char*)malloc(sizeof(char)*largo);
    for (i = 0; i < largo; i++) {
        if (isalpha(palabra[i])!=0 || isdigit(palabra[i])!=0 || palabra[i]== '-') {
            nuevaPalabra[j] = palabra[i];
            j++;
        }
    }
    //printf("%s\n",nuevaPalabra);
    return nuevaPalabra;
}

void lecturaArchivo(char* nombreArchivo, Lista * list){
    FILE *archivo;

 	char caracteres[100];
    const char s[2] = " ";
    char *token;
    char *palabra;

 	archivo = fopen(nombreArchivo,"r");

 	if (archivo == NULL)
 		exit(1);

 	printf("\nEl contenido del archivo de prueba es \n\n");
    int id = 1;

 	while (feof(archivo) == 0)
 	{
 		fgets(caracteres,100,archivo);
        token = strtok(caracteres, s);
        while( token != NULL ) {
            palabra = LimpiarPalabra(token);
            agregar(list,palabra,id++);
            token = strtok(NULL, s);
        }
 	}
    fclose(archivo);
	return;
}
