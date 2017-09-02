#pragma once

#include <stdio.h>
#include <string.h>
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

void lecturaArchivo(char* nombreArchivo, Lista * list){
    FILE *archivo;

 	char caracteres[100];

 	archivo = fopen(nombreArchivo,"r");

 	if (archivo == NULL)
 		exit(1);

 	printf("\nEl contenido del archivo de prueba es \n\n");
    int id = 1;
 	while (feof(archivo) == 0)
 	{
 		fgets(caracteres,100,archivo);
        agregar(list,caracteres,id++);
 		//printf("%s\n",caracteres);
 	}
        fclose(archivo);
	return;
}
