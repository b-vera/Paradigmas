#lang racket
(define (getElementByIndex L i)
  (if (null? L)
      null
      (if (= i 0)
          (car L)
          (getElementByIndex (cdr L) (- i 1))
      )
  )
)

(define (setElementByIndex L i e)
  (if (null? L)
      null
      (if (= i 0)
          (cons e (cdr L))
          (cons (car L) (setElementByIndex (cdr L) (- i 1) e))
       )
    )
)

(define (removeElementByIndex L i)
  (if (null? L)
      null
      (if (= i 0)
          (cdr L)
          (cons (car L) (removeElementByIndex (cdr L) (- i 1)))
       )
    )
)

(define (myMap f L)
  (if (null? L)
      null
      (cons (f (car L)) (myMap f (cdr L))))
  )











      