#lang racket
;0 - Representacion Lista de Enteros (list dia mes año)

;1 - Constructores
(define (bisiesto? a)
  (and (integer? a)
       (or (and (= (remainder a 4) 0)
               (not (= (remainder a 100) 0))
          )
          (= (remainder a 400) 0)
          )
       )
)

(define (getNumeroDias m a)
  (if (integer? m)
      (cond ((or (= m 1) (= m 3) (= m 5) (= m 7) (= m 8) (= m 10) (= m 12)) 31)
            ((and (= m 2) (if ((lambda (a) (integer? a)
       (or (and (= (remainder a 4) 0)
               (not (= (remainder a 100) 0))
          )
          (= (remainder a 400) 0)
          )
       ) a) 29 28)))
            ((or (= m 4) (= m 6) (= m 9) (= m 11)) 30)
            (else 0)
      )
      0
  )
)

(define (fecha dia mes agno)
  (if (and
       (integer? dia) (integer? agno)
       (> dia 0) (<= dia (getNumeroDias mes agno))
       (> mes 0) (< mes 13)
       )
      (list dia mes agno)
      null
  )
)