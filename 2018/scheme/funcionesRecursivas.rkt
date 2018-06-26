#lang racket
(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))
   )
 )

(define (factorial2 n a)
  (if (= n 0)
      a
      (factorial2 (- n 1) (* n a))
  )
)

(define (fib n)
  (if (or (= n 0) (= n 1))
      n
      (+ (fib (- n 1)) (fib (- n 2)))
   )
)

(define (bin n k)
  (if (or (= k 0) (= n k) )
      1
      (+ (bin (- n 1) k) (bin (- n 1) (- k 1)))
   )
 )








