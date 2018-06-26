#lang racket

(define (esMenor a b)
  (if (> a b)
      #f
      #t
      )
  )

(define (sumCuadrados a b c)
  (cond
    [(and (< a b) (< a c)) (+ (* c c) (* b b))]
    [(and (< b a) (< b a)) (+ (* c c) (* a a))]
    [(and (< c a) (< c b)) (+ (* a a) (* b b))]))

(define (factorial n)
  (cond
    [(= n 1) 1 ]
    [else (* (factorial (- n 1)) n)]
  )
  )

(define (fibs n)
  (if (or (= n 0) (= n 1)) 1 (+ (fibs(- n 1)) (fibs(- n 2)) )))

(define (mcd a b)
  (if (< a b)
         (if (= (remainder b a) 0)
             a
             (mcd (* a a) b))
         (if (= (remainder a b) 0) 
             b
             (mcd a (* b b)))
         )
  )

(define (minimo a b c d e)
  (cond
    [(and (<= a b) (<= a c) (<= a d) (<= a e)) a]
    [(and (<= b a) (<= b c) (<= b d) (<= b e)) b]
    [(and (<= c a) (<= c b) (<= c d) (<= c e)) c]
    [(and (<= d a) (<= d b) (<= d c) (<= d e)) d]
    [(and (<= e a) (<= e b) (<= e c) (<= e d)) e]))
