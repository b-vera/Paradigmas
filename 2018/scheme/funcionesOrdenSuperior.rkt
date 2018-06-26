#lang racket
;composicion de funciones
(define (f x) (* x x))
(define (g y) (+ y 2))

((compose f g) 3)

(define h (compose f g))

(h 3)

;funciones apply to all
(map sqrt (list 1 4 9 16 25))

;mi implementacion de map
;recursion lineal
(define (mymap f L)
  (if (null? L)
      null
      (cons (f (car L)) (mymap f (cdr L))) ;queda estado pendiente
   )
 )

;llamado a mymap con funcion anonima
(mymap (lambda (x) (* x x))