#lang racket

(define matriz (list (list 1 (cons 2 3) (cons 3 7)) (list 3 (cons 1 2) (cons 2 8)) (list 4 (cons 4 9))))

;pregunta 1

;1.
;Dominio   = numeros naturales
;Recorrido = numeros naturales
;recursion = recursion de cola
(define (getElemento nCol nFil matriz)
  
  (if (= (caar matriz) nCol)
      (getElemento2 nFil (car matriz))
      (getElemento nCol nFil (cdr matriz))
      )
)

(define (getElemento2 nFil matriz)
  (if (= (caadr matriz) nFil)
      (cdadr matriz)
      (getElemento2 nFil (cdr matriz))
      )
)


;2.
;dominio   = lista, nros reales
;recorrido = nros reales
;recursion = recursion de cola
(define (getColumna nCol matriz)
  (if (= (caar matriz) nCol)
      (car matriz)
      (getColumna nCol (cdr matriz))
      )
  )

;3.
(define (getNumCol col)
  (car col)
)

;4.
(define (getFila nFila col)
  (if (= (caadr col) nFila )
      (cadr col)
      (getFila nFila (cdr col))
      )
  )

;5.

(define (getFilas col)
      (cdr col)
  )

;6.
(define (getNumFila fil)
  (car fil)
  )

;7.
(define (getElementoFila fil)
  (cdr fil)
  )

;pregunta 2.1

(define (setElementoFila fil elemento)
  (cons (car fil) elemento)
  )

(define (setNumFila fil nfil)
  (cons nFil (cdr fil))
  )

(define (setNumCol col nCol)
  (list nCol (cdr col))
  )
