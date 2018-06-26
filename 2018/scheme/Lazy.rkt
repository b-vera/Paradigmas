#lang racket
;Eager vs Lazy (ansiosa vs perezosa)

(define (fib n)
  (if (or (= n 0) (= n 1))
      1
      (+ (fib (- n 1)) (fib (- n 2)))))

;eager
(fib 40)

;lazy
(lazy (fib 40))
(define C (lazy (fib 40)))
(define a1 (lazy (fib 40)))
(define L2 (list a1 a1 a1 a1))
(force a1)
(define L1 (list (lazy (fib 35)) (lazy (fib 35))
(length L1)
(length (list (fib 35) (fib 35) (fib 35) (fib 35)))