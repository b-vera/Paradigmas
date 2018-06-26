#lang racket

;RUN: 18.863.588-1
;Sección de Laboratorio: L-3 José Allende
;Fecha: 17-11-2017
;Objetivo del código: encontrar la mayor representacion de trifuerza a partir de distintas entradas indicando base y altura de esta.
;https://docs.racket-lang.org/reference/index.html

(define entrada "#
# # #
# # # # #
# # # # # # #
# # # # # # # # #
# _ _ _ _ _ _ _ _ _#
# # # _ _ _ _ _ _ _ # # #
# # # # # _ _ _ _ _ # # # # #
# # # # # # # _ _ _ # # # # # # #
# # # # # # # # # _ # # # # # # # # #")

(define entrada2 "_
# _ _
# # # # # 
# # # # # _ #
# # # # # # # # # 
# _ # _ _ _ _ _ # _ _
_ # # # # _ _ _ # # # # #
_ # # # # # # _ # # # # # # _
# # # # # # # # # _ _ # # # _ _ _
# # # # # _ _ # # # _ _ # # _ _ _ _ _")

(define entrada3 "_
# _ _
# _ # _ _
# # # _ _ _ _")

(define (altura-triangulo largo-triangulo)  ;altura triangulo
  (/(sqrt(* 4 largo-triangulo))2)
  )

(define (trifuerza? triangulo) ;revisa si un triangulo es trifuerza si lo es retorna su altura si no 0
  (if (and (even? (altura-triangulo (length triangulo)))(equal? triangulo (trifuerza (altura-triangulo (length triangulo)))))
      (altura-triangulo (length triangulo))
      0 
      )
  )

(define (limpiarLista L salida) ;le borra los espacios y los saltos de linea a un triangulo
  (define (add l salida)
    (limpiar (cdr l) (append salida (list(car l))))
    )
  (define (limpiar L salida)
    (if (pair? L)
        (if (char=? (car L) #\#)
            (add L salida)
            (if (char=? (car L) #\_)
                (add L salida)
                (limpiarLista (cdr L) salida)
                )
            )
        salida
        )
    )
  (limpiar L salida)
  )

(define (limpiar L salida) ; igual a la de arriba pero creo que tiene un error :c
  (if (pair? L)
      (if (or (char=? (car L) #\#) (char=? (car L) #\_))
          (limpiar (cdr L) (append salida (list(car L))))
          (limpiar (cdr L) salida)
      )
      salida
      )
  )

(define (conseguirTriangulo t baseI baseF pos) ;dadas la posicion pos construye un triangulo necesita la altura donde empieza el triangulo y la altura maxima (baseI baseF respectivamente)
  (define (saltos n)
    (- (* 2 n) 1)
    )
  (define (conseguirLinea t pos cantidad salida)
    (if (= 0 cantidad)
        salida
        (conseguirLinea t (+ 1 pos) (- cantidad 1) (append salida (list (list-ref t pos))))
        )
    )
  (define (conseguir t baseI baseF baseActual pos salida)
    (if (> baseI baseF)
        salida
        (conseguir t (+ baseI 1) baseF (+ baseActual 1) (+ pos (saltos baseI)) (conseguirLinea t pos (saltos baseActual) salida))
        )
    )
  (if (and (= baseI 1)(= baseF (altura-triangulo (length t))))
      t
      (conseguir t baseI baseF 1 pos '())
      )
  )


(define (eliminar n l) ;elimina el n-esimo termino de una lista
  (if (= n 0)
      (cdr l)
      (append (list (car l)) (eliminar (- n 1) (cdr l)))
      )
  )

(define (calcular-elementos altura) ; calcula la cantidad de elementos que tiene que tener la lista dada la altura de un triangulo
  (if ( = altura 1)
      1
      (+ (- (* altura 2) 1) (calcular-elementos (- altura 1)))
      )
  )

(define (listaEliminarD altura) ;elimina todos los elementos a la derecha de un triangulo, es decir lo achica 1 de altura pero por la derecha
  (define (eliminar altura salida)
    (if ( = 1 altura)
        (sort (append salida (list 0)) >)
        (eliminar (- altura 1) (append salida (list (- (calcular-elementos altura) 2) (- (calcular-elementos altura) 1))))
        )
    )
  (eliminar altura '())
  )

(define (listaEliminarI altura); lo mismo que arriba pero por la izquierda (no la hice :c) pero ningua de las 2 se usa
  (define (eliminar altura salida)
    (if  ( = 1 altura)
        (sort (append salida (list 0)) >)
        (eliminar (- altura 1) (append salida (list (- (calcular-elementos altura) 2) (- (calcular-elementos altura) 1))))
        )
    )
  (eliminar altura '())
  )

(define (eliminarLista t l) ;elimina elementos en base a una lista (si la lista es (1 2 3) eliminara los indices 1 2 3)
  (if (pair? l )
      (eliminarLista (eliminar (car l) t) (cdr l) )
      t
      )
  )

(define (trifuerza altura) ;crea una lista que contiene una trifuerza en base a la altura dada
  (define (agregar n salida) ;agrega n #
    (if ( = n 1)
        (append salida (list #\#))
        (agregar (- n 1) (append salida (list #\#)))
        )
    )
  (define (agregar2 n salida) ;agrega n _
    (if ( = n 1)
        (append salida (list #\_))
        (agregar2 (- n 1) (append salida (list #\_)))
        )
    )
  (define (segundaParte t negras blancas veces) ;despues de crear los primeros # agrega desde la primera fila que tiene _ es decir recibe una lista con toda la cuspide de # y va completando la trifuerza
    (if ( = veces 0)
        t
        (segundaParte (agregar negras (agregar2 blancas (agregar negras t))) (+ negras 2) (- blancas 2) (- veces 1))
        )
    )
  (segundaParte (agregar (calcular-elementos (/ altura 2)) '()) 1 (- altura 1) (/ altura 2))
  )

(define (eliminarUltimo lista) ;elimina el ultimo elemento de una lista
  (reverse (cdr (reverse lista)))
  )

(define (quitarBase altura t) ;achica un triangulo eliminando todos los elementos de la base
  (define (saltos n) ;calcula la cantidad de elementos de la base
    (- (* 2 n) 1)
    )
  (define (eliminar n t) ;borra n elementos de un triagulo t siempre eliminando el ultimo
    (if (= n 0)
        t
        (eliminar (- n 1) (eliminarUltimo t))
        )
    )
  (eliminar (saltos altura) t)
  )

(define (conseguirMayorTrifuerza t);dado un triangulo cualquiera, lo va achicando y revisando si es trifuerza, devuelve la altura de la mayor trifuerza encontrada
  (define (conseguirMayor t n)
    (if ( = (altura-triangulo (length t)) 1)
        n
        (conseguirMayor (quitarBase (altura-triangulo (length t)) t) (if ( = n 0)
                                                                         (trifuerza? t)
                                                                         n
                                                                         )
                        )
        )
    )
  (conseguirMayor t 0)
  )

(define (listaValores n) ;crea una lista de todos los valores en los que puede inciar un triangulo dado el largo del triangulo
  (define (lista c n salida)
    (if (= c n)
        salida
        (lista (+ c 1) n (append salida (list c)))
        )
    )
  (define (armarLista n pos final salida)
    (if ( = n final)
        salida
        (if (even? n)
            (armarLista (+ n 1) (+ pos (- (* 2 n) 1)) final (append salida (filter (compose not even?) (lista pos (+ pos (- (* 2 n) 1)) '() ) )) )
            (armarLista (+ n 1) (+ pos (- (* 2 n) 1)) final (append salida (filter even? (lista pos (+ pos (- (* 2 n) 1)) '() ) )) )
            )
        )
    )
  (armarLista 1 0 (+ n 1) '())
  )

(define (paresAltura lista) ;le agregar a un incio de triangulo, la altura asociada a esa posición por ejemplo si un triangulo parte en la posción 0, la altura asociada a esa posicion es 1, si un triangulo parte en 4, la altura asociada a esa posición es 3
  (define (paresAltura altura contador actual lista salida)
    (if (pair? lista)
        (if ( = contador altura)
            (paresAltura (+ 1 altura) 0 0 lista salida)
            (paresAltura altura (+ 1 contador) actual (cdr lista) (append salida (list(cons (car lista) altura))))
            )
        salida
        )
    )
  (paresAltura 1 0 0 lista '())
)

(define (buscarTrifuerza t); busca en todos los sub triangulos posibles cual es la altura de su trifuerza máxima, luego devuelve la mayot altura entre todos los subtriangulos
  (define (alturaMaxima pares contador t maxAltura)
    (if (pair? pares)
        (if (< contador (conseguirMayorTrifuerza (conseguirTriangulo t (cdr (car pares)) maxAltura (car (car pares)))  ))
            (alturaMaxima (cdr pares) (conseguirMayorTrifuerza (conseguirTriangulo t (cdr (car pares)) maxAltura (car (car pares))) ) t maxAltura )
            (alturaMaxima (cdr pares) contador t maxAltura)
            )
         contador
        )
    )
  (alturaMaxima (paresAltura (listaValores (altura-triangulo (length t)))) 0 t (altura-triangulo (length t)))
  )


;;;;;IMPORTANTE;;;;;;;
;Para usar el código, antes de hacer (buscarTrifuerza t)
;Se debe filtar el triangulo es decir el t debe ser (limpiar (string->list "triangulo string") '())
(define t (limpiar (string->list entrada) '()));modificar entrada por el nombre de su triangulo string
;(buscarTrifuerza t)

(define b
  (if (= (buscarTrifuerza t) 0)
      "No existe trifuerza"
      (-(*(buscarTrifuerza t)2)1)
      )
  )


(define mostrarResultado
  (if(= (buscarTrifuerza t ) 0)
     "No existe trifuerza" 
      (buscarTrifuerza t)
      )
  )

"Base:"(display b)
(display "\n")
"Altura:"(display mostrarResultado)


