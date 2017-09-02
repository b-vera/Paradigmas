#include <stdio.h>

int main(){
    int a = 5;
    int *p = &a;

    printf("a vale = %d\n",a );
    printf("p puntero vale = %d\n",*p );

    //se le suma uno al puntero
    *p = *p+1;

    //valor de p y a
    printf("p puntero ahora vale = %d\n",*p );
    printf("a ahora vale = %d\n",a);
    return 0;
}
